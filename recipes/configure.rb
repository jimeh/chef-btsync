node_config = node["btsync"].to_hash

# Allow data bag to override node attributes.
if data_bag("btsync").include?("config")
  bag_config = data_bag_item("btsync", "config")
end

config = node_config.merge(bag_config || {})

# Set group if not specified.
config["group"] ||= config["user"]

# Set home folder.
if config["home"].to_s == ""
  config["home"] = `getent passwd #{config["user"]} | cut -d: -f6`.strip
end

if config["home"].to_s == ""
  config["home"] = "/home/#{config["user"]}"
end

if config["home"].to_s == ""
  raise "Can't determine #{username}'s home folder."
end

# Ensure absolute paths.
["storage_path", "pid_file", "config_file"].each do |opt|
  config[opt] = "#{config["home"]}/#{config[opt]}" if config[opt][0] != "/"
end

# Ensure shared folder defaults are fully set.
if bag_config["shared_folder_defaults"]
  config["shared_folder_defaults"] = node_config["shared_folder_defaults"].
    merge(bag_config["shared_folder_defaults"])
end

# Ensure shared folders include default values, and dir is absolute.
config["shared_folders"] = config["shared_folders"].map do |folder|
  folder = config["shared_folder_defaults"].merge(folder)

  if folder["dir"][0] != "/"
    folder["dir"] = "#{config["home"]}/#{folder["dir"]}"
  end

  folder
end

directories = [
  config["storage_path"],
  File.dirname(config["pid_file"]),
  File.dirname(config["config_file"])
].uniq

directories.each do |path|
  directory path do
    owner config["user"]
    group config["group"]
    mode "0775"
    action :create
    recursive true
  end
end

(config["shared_folders"] || []).each do |folder|
  directory "#{folder["dir"]}" do
    owner config["user"]
    group config["group"]
    mode "0775"
    recursive true
    action :create
  end

  template "#{folder["dir"]}/.SyncIgnore" do
    source "SyncIgnore.erb"
    owner config["user"]
    group config["group"]
    mode "0644"
    notifies :restart, "service[btsync]"
    variables(:ignores => folder["sync_ignore"])
  end
end

template "#{config['config_file']}" do
  source "btsync-config.json.erb"
  owner config["user"]
  group config["group"]
  mode "0644"
  notifies :restart, "service[btsync]"
  variables(:config => config)
end

template "/etc/init/btsync.conf" do
  source "upstart-conf.erb"
  mode "0644"
  variables(
    :config     => config,
    :executable => node["btsync"]["bin_dir"] + "/btsync")
  notifies :restart, "service[btsync]", :immediately
end

service "btsync" do
  service_name "btsync"
  provider Chef::Provider::Service::Upstart
  start_command   "/sbin/start btsync"
  stop_command    "/sbin/stop btsync"
  status_command  "/sbin/status btsync"
  restart_command "/sbin/restart btsync || /sbin/start btsync"
  supports [:start, :stop, :status, :restart]
  action :enable
end
