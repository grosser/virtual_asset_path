require 'test/test_helper'

class VirtualAssetPathTestController < ActionController::Base
  def index
  end
end

class VirtualAssetPathTest < ActionController::TestCase
  def setup
    @controller = VirtualAssetPathTestController.new
  end

  test "caches actions" do
    get :index
    @response.body.strip.should == 'TEST'
  end
end
