# chef-btsync

A simple and quickly hacked together chef cookbook for installing and
configuring BTSync on Ubuntu for my own personal needs. It supports loading
config and the shared folders list from attributes and/or data bags.

Loosely inspired by [Nitecon/btsync](https://github.com/Nitecon/btsync), and
main differences are:

- Works with in chef-solo as it does not use search.
- Supports loading config from data bags, allowing shared folder secrets to be
  kept safe in data bags.

Have a look at the default attributes file for a complete list of options
available to set.


## Supported Platforms

- Ubuntu 12.04 (later versions may work, but have not been tested on).


## Recipes

- `recipe[btsync]` - Installs, and configures, BTSync.
- `recipe[btsync::install]` - Installs BTSync.
- `recipe[btsync::configure]` - Configures BTSync.


## Example Data Bag

data_bags/btsync/config.json:

```javascript
{
  "id": "config",
  "user": "jimeh",
  "listening_port": "49034",
  "webui": {
    "enabled": false,
    "listen": "0.0.0.0:8888",
    "login": "admin",
    "password": "[PASSWORD_GOES_HERE]"
  },
  "shared_folder_defaults": {
    "use_relay_server": "true",
    "use_tracker": "true",
    "use_dht": "false",
    "search_lan": "true",
    "use_sync_trash": "false",
    "known_hosts": []
  },
  "shared_folders": [
    {
      "secret": "[SECRET_GOES_HERE]",
      "dir": "BTSync/dotfiles"
    },
    {
      "secret": "[SECRET_GOES_HERE]",
      "dir": "BTSync/Main"
    }
  ]
}
```

## License

(The MIT license)

Copyright (c) 2014 Jim Myhrberg.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
