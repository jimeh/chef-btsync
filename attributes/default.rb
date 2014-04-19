default["btsync"]["bin_dir"] = "/usr/local/bin"
default["btsync"]["user"]    = "root"
# default["btsync"]["group"] = "root" # defaults to same as user

# Below paths are relative to user's home folder unless they start with a
# slash (/) in which case they're absolute.
default["btsync"]["storage_path"] = ".btsync"
default["btsync"]["pid_file"]     = ".btsync/sync.pid"
default["btsync"]["config_file"]  = ".btsync/config.json"

default["btsync"]["device_name"]       = Chef::Config[:node_name]
default["btsync"]["listening_port"]    = "0" # "0" means random port
default["btsync"]["webui"]["enabled"]  = false
default["btsync"]["webui"]["listen"]   = "0.0.0.0:8888"
default["btsync"]["webui"]["login"]    = "admin"
default["btsync"]["webui"]["password"] = "password"

default["btsync"]["use_upnp"]               = "true"
default["btsync"]["check_for_updates"]      = "true"
default["btsync"]["download_limit"]         = "0"
default["btsync"]["upload_limit"]           = "0"
default["btsync"]["disk_low_priority"]      = "false"
default["btsync"]["folder_rescan_interval"] = "600"
default["btsync"]["lan_encrypt_data"]       = "true"
default["btsync"]["lan_use_tcp"]            = "true"
default["btsync"]["rate_limit_local_peers"] = "false"
default["btsync"]["sync_max_time_diff"]     = "300"
default["btsync"]["sync_trash_ttl"]         = "30"
default["btsync"]["shared_folders"]         = []

default["btsync"]["shared_folder_defaults"]["use_relay_server"] = "true"
default["btsync"]["shared_folder_defaults"]["use_tracker"]      = "true"
default["btsync"]["shared_folder_defaults"]["use_dht"]          = "false"
default["btsync"]["shared_folder_defaults"]["search_lan"]       = "true"
default["btsync"]["shared_folder_defaults"]["use_sync_trash"]   = "false"
default["btsync"]["shared_folder_defaults"]["known_hosts"]      = []
default["btsync"]["shared_folder_defaults"]["sync_ignore"] = [
  ".DS_Store",
  ".DS_Store?",
  ".AppleDouble",
  "._*",
  ".Spotlight-V100",
  ".Trashes",
  "ehthumbs.db",
  "desktop.ini"
]


#
# BTSync Download URLs
#

default["btsync"]["download_url"]["32bit"] =
  "http://download-lb.utorrent.com/endpoint/btsync/os/linux-i386/track/stable"
default["btsync"]["download_url"]["64bit"] =
  "http://download-lb.utorrent.com/endpoint/btsync/os/linux-x64/track/stable"
