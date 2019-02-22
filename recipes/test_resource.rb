# Author:: Christopher Yocum <cyocum@gmail.com>
# Cookbook Name:: supervisor
# Recipe:: test_resource

execute "install nmap" do
  command "yum install -y nmap"
end

supervisor_service "enabling netcat" do
  action :enable
  service_name "netcat"
  command "nc -l -p 1234 -e /bin/sh"
end

supervisor_service "netcat" do
  action :start
  
end
