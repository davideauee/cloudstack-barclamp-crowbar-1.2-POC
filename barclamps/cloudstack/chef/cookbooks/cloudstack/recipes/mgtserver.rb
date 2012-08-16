#
# Cookbook Name:: cloudstack
# Recipe:: mgtserver
#
#

package "cloud-client" do
  action :install
end

# setup the DB
db_servers = search(:node, 'role:cloudstack-dbserver')
if db_servers.length == 0
  db_servers = search(:node, 'recipes:cloudstack\\:\\:dbserver') || []
end
if db_servers.length > 0
  db_host = db_servers[0][:fqdn]
  cloud_pwd = node[:cloudstack][:mysql][:cloud_pwd]
  root_pwd = node[:cloudstack][:mysql][:root_pwd]

  execute "setup cloud DB" do
    command "cloud-setup-databases cloud:#{cloud_pwd}@#{db_host} --deploy-as=root:#{root_pwd} && touch /opt/dell/cloudstack/install/log/cloudDbConfigured"
    creates "/opt/dell/cloudstack/install/log/cloudDbConfigured"
  end
end

# setup the mgt service
execute "setup-cloud-MGT" do
  command "cloud-setup-management && touch /opt/dell/cloudstack/install/log/cloudMgtConfigured"
  creates "/opt/dell/cloudstack/install/log/cloudMgtConfigured"
end


###########################################################
# hack to get the management server working on a 10.10 host

package "openjdk-6-jdk" do
  action :install
end

directory "/usr/share/java/cloud-plugins" do
  owner "root"
  group "root"
  mode "0755"
  recursive true
  action :create
end

service "cloud-management" do
  supports :status => true, :restart => true
  action [ :enable]
end

link "/usr/share/java/cloud-plugins/ecj.jar" do
  to "/usr/share/java/ecj.jar"
  link_type :symbolic
  notifies :restart, "service[cloud-management]"
end

# end hack
###########################################################

# setup secondary storage
if node[:cloudstack][:secondary_storages]
  node[:cloudstack][:secondary_storages].each do |secondary_storage|
    directory "/mnt/secondary" do
      owner "root"
      group "root"
      mode "0755"
      recursive true
      action :create
    end
    execute "temporary mount secondary share" do
      command "mount -t nfs #{secondary_storage[:host]}:#{secondary_storage[:mount]} /mnt/secondary"
    end
    mount_label = "#{secondary_storage[:host]}#{secondary_storage[:mount]}".tr("/", "_").tr(".", "_")
    execute "install secondary storage for #{mount_label}" do
      command "/usr/lib64/cloud/agent/scripts/storage/secondary/cloud-install-sys-tmplt -m /mnt/secondary -u http://download.cloud.com/releases/2.2.0/systemvm.vhd.bz2 -h xenserver -F && touch /opt/dell/cloudstack/install/log/secondaryStorageSetup_#{mount_label}"
      creates "/opt/dell/cloudstack/install/log/secondaryStorageSetup_#{mount_label}"
      timeout 1200
    end
    execute "unmount secondary share" do
      command "umount /mnt/secondary"
    end
  end
end

# ... add storage to the appropriate zones via web admin UI? cloudadm? 


