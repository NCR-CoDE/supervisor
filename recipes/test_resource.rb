# Author:: Christopher Yocum <cyocum@gmail.com>
# Cookbook Name:: supervisor
# Recipe:: test_resource

supervisor_service "enabling netcat" do
  action :enable
  service_name "foo" 
end
