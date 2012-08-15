#
# Cookbook Name:: cloudstack
# Recipe:: dbserver
#
#

package "mysql-server" do
  action :install
  notifies :restart, "service[mysql]", :immediately
end

service "mysql" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

template "/etc/mysql/my.cnf" do
  source "mysql/my.cnf.erb"
end

directory "/opt/poc/cloudstack/install/mysql/" do
  owner "root"
  group "root"
  mode "0755"
  recursive true
  action :create
end

template "/opt/poc/cloudstack/install/mysql/setup.sql" do
  source "mysql/setup.sql.erb" 
end

execute "setup-mysql" do
  command "mysql -u root < /opt/poc/cloudstack/install/mysql/setup.sql && touch /opt/poc/cloudstack/install/log/mysqlConfigured"
  creates "/opt/poc/cloudstack/install/log/mysqlConfigured"
  action :run
  notifies :restart, "service[mysql]"
end
# command that i actually wanted to run initially but that, for some reasons, did persist the changes:
# mysqld_safe --init-file=/opt/poc/cloudstack/install/mysql/setup.sql
