#
# Cookbook Name:: cloudstack
# Recipe:: setuprepos
#
#

remote_directory "/opt/dell/cloudstack/install" do
  source "cloudstackInstall"
  owner "root"
  group "root"
  mode "0644"
  files_owner "root"
  files_group "root"
  files_mode "0644"
  overwrite true
end

cookbook_file "/etc/apt/sources.list.d/cloudstack.list" do
  owner "root"
  group "root"
  mode "0644"
  source "cloudstack.deb.list"
  action :create
end

execute "sync-package-repos" do
  command "aptitude update && touch /opt/dell/cloudstack/install/log/reposSynced"
  creates "/opt/dell/cloudstack/install/log/reposSynced"
  action :run
end

directory "/opt/dell/cloudstack/install/log" do
  owner "root"
  group "root"
  mode "0755"
  recursive true
  action :create
end

