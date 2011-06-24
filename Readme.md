Virtual asset paths for great caching.

 - cacheable without query params
 - cached by MD5 of content (only change when the content changes / same on all servers)


# Results

    /foo/bar.jpg ... will be ...

    # default + simple rewrite rules
    /asset-v1afd23/foo/bar.jpg  # style: folder   method: MD5

    # rails3-ish, but complicated rewrite rules
    /foo/bar-asset-v1afd23.jpg  # style: suffix   method: MD5

    # no rewrite rule needed (great for development)
    /foo/bar.jpg?1afd23         # style: query    method: MD5

    # configure
    VirtualAssetPath.style = :folder # default
    VirtualAssetPath.style = :MD5    # default

# Install
(only tested on rails 2 atm)

    ./script/plugin install git://github.com/grosser/virtual_asset_path.git
Or
    gem install virtual_asset_path

# Nginx config

    rewrite  ^/asset-v[a-z0-9]+(.*) $1; # style: folder
    ??? # style: suffix

# Apache config

    ??? # style: folder
    ??? # style: suffix

Author
======
[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
Hereby placed under public domain, do what you want, just do not hold me accountable...
