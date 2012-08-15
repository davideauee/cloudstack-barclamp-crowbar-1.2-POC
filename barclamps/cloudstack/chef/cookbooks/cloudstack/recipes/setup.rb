#
# Cookbook Name:: Cloudstack
# Recipe:: setup
#

include_recipe "#{@cookbook_name}::common"

bash "tty linux setup" do
  cwd "/tmp"
  user "root"
  code <<-EOH
	mkdir -p /var/lib/cloudstack/
	curl #{node[:cloudstack][:tty_linux_image]} | tar xvz -C /tmp/
	touch /var/lib/cloudstack/tty_setup
  EOH
  not_if do File.exists?("/var/lib/cloudstack/tty_setup") end
end
