module VirtualAssetFolder
  class << self
    attr_accessor :hashing_method, :hashing_style
  end
end

module ActionView::Helpers::AssetTagHelper
  def rewrite_asset_path_with_virtual_folder(source)
    asset_path = rewrite_asset_path_without_virtual_folder(source)
    id = virtual_asset_folder(asset_path)
    if id.present?
      case VirtualAssetFolder.hashing_style
      when :folder, nil then "/asset-v#{id}#{asset_path}"
      when :query then "#{asset_path}?#{id}"
      end
    else
      asset_path
    end
  end
  alias_method_chain :rewrite_asset_path, :virtual_folder

  def virtual_asset_folder(source)
    if asset_id = ENV["RAILS_ASSET_ID"]
      asset_id
    else
      if @@cache_asset_timestamps && (asset_id = @@asset_timestamps_cache[source])
        asset_id
      else
        path = File.join(ASSETS_DIR, source)
        asset_id = File.exist?(path) ? virtual_asset_folder_id(path) : ''

        if @@cache_asset_timestamps
          @@asset_timestamps_cache_guard.synchronize do
            @@asset_timestamps_cache[source] = asset_id
          end
        end

        asset_id
      end
    end
  end

  # overwrite to disable / use mtime ?
  def virtual_asset_folder_id(path)
    case VirtualAssetFolder.hashing_method
    when :md5,nil then Digest::MD5.file(path).hexdigest[0..6]
    when :mtime then File.mtime(path).to_i.to_s
    else
      raise "unsupported hashing method"
    end
  end

  # no longer needed <-> would conflict
  def rails_asset_id(*args)
    nil
  end
end
