#
# Cookbook Name:: glance
# Recipe:: api
#
#

include_recipe "#{@cookbook_name}::common"

cloudstack_service "api"

node[:cloudstack][:monitor][:svcs] <<["cloudstack-api"]

