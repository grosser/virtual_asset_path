Use MD5 prefix `/asset-v1adad1/foo.js` or timestamp prefix `/asset-1312313/foo.js` or MD5 suffix `/foo.js?1ada1` instead of standard Rails asset-id.


# Install

    rails plugin install git://github.com/grosser/virtual_asset_folder.git
Or
    gem install virtual_asset_folder


# Nginx config
    rewrite  ^/asset-v[a-z0-9]+(.*) $1;

