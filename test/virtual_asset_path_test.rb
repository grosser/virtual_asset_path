require 'test/test_helper'

class VirtualAssetPathTestController < ActionController::Base
  def index
  end
end

#noinspection RubyArgCount
class VirtualAssetPathTest < ActionController::TestCase
  def setup
    VirtualAssetPath.method = nil
    VirtualAssetPath.style = nil
    ENV["RAILS_ASSET_ID"] = nil
    @controller = VirtualAssetPathTestController.new
    ActionView::Base.send :class_variable_set, '@@asset_timestamps_cache', {}
    ActionView::Base.send :class_variable_set, '@@cache_asset_timestamps', true
  end

  test "adds folder to found assets" do
    get :index, :image => '/bar/foo.jpg'
    @response.body.strip.should == "<img alt=\"\" src=\"/asset-vd41d8cd/bar/foo.jpg\" />"
  end

  test "does not add virtual path to unknown assets" do
    get :index, :image => '/bar/not_found.jpg'
    @response.body.strip.should == "<img alt=\"\" src=\"/bar/not_found.jpg\" />"
  end

  test "adds RAILS_ASSET_ID to found assets" do
    ENV["RAILS_ASSET_ID"] = 'abc'
    get :index, :image => '/bar/foo.jpg'
    @response.body.strip.should == "<img alt=\"\" src=\"/asset-vabc/bar/foo.jpg\" />"
  end

  test "caches found asset ids" do
    file = 'test/public/cached.jpg'
    hash = '0cc175b'

    begin
      File.open(file,'w'){|f| f.write 'a' }
      get :index, :image => '/cached.jpg'
      @response.body.strip.should == "<img alt=\"\" src=\"/asset-v#{hash}/cached.jpg\" />"

      File.open(file,'w'){|f| f.write 'b' }
      get :index, :image => '/cached.jpg'
      @response.body.strip.should == "<img alt=\"\" src=\"/asset-v#{hash}/cached.jpg\" />"
    ensure
      `rm #{file}`
    end
  end

  test "caches with mtime" do
    VirtualAssetPath.method = :mtime
    get :index, :image => '/bar/foo.jpg'
    @response.body.strip.should == "<img alt=\"\" src=\"/asset-v#{File.mtime('test/public/bar/foo.jpg').to_i}/bar/foo.jpg\" />"
  end
end
