if node["kernel"]["machine"] == "x86_64"
  download_url = node["btsync"]["download_url"]["64bit"]
else
  download_url = node["btsync"]["download_url"]["32bit"]
end

if download_url
  remote_file "#{Chef::Config[:file_cache_path]}/btsync.tar.gz" do
    source download_url
    backup false
    notifies :run, "execute[unpack-btsync-tarball]", :immediately
    not_if "test -f #{node["btsync"]["bin_dir"]}/btsync"
  end

  execute "unpack-btsync-tarball" do
    cwd "#{Chef::Config[:file_cache_path]}/"
    command "tar -xvzf #{Chef::Config[:file_cache_path]}/btsync.tar.gz && " +
      "mv btsync #{node["btsync"]["bin_dir"]}/ && " +
      "chmod +x #{node["btsync"]["bin_dir"]}/btsync && " +
      "rm #{Chef::Config[:file_cache_path]}/btsync.tar.gz"
    creates "#{node["btsync"]["bin_dir"]}/btsync"
    action :nothing
  end
else
  puts "ERROR: Can't determine host architecture (32/64bit)."
end
