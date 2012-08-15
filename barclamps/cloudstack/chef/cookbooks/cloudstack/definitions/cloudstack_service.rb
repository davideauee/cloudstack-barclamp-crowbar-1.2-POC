define :cloudstack_service do

  cloudstack_name="cloudstack-#{params[:name]}"

  service cloudstack_name do
    if (platform?("ubuntu") && node.platform_version.to_f >= 10.04)
      restart_command "restart #{cloudstack_name}"
      stop_command "stop #{cloudstack_name}"
      start_command "start #{cloudstack_name}"
      status_command "status #{cloudstack_name} | cut -d' ' -f2 | cut -d'/' -f1 | grep start"
    end
    supports :status => true, :restart => true
    action [:enable, :start]
    subscribes :restart, resources(:template => node[:cloudstack][:config_file])
  end

end
