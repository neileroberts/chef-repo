#
# Cookbook Name:: ies-repovault
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "/sysadmin" do
owner 'root'
group 'root'
mode '0755'
action :create
end

if node['platform_version'] =="7.0"
template '/sysadmin/ies-repovault.sh' do
  source 'ies-repovault-RH7.sh'
end
else
template '/sysadmin/ies-repovault.sh' do
  source 'ies-repovault.sh'
end

execute 'chmod +x /sysadmin/ies-repovault.sh' do
end

execute '/sysadmin/ies-repovault.sh' do
end

execute 'yum update -y' do
  
end
end