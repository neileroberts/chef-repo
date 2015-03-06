#
# Cookbook Name:: ies-repovault
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node['platform_version'] =="7.0"
template '/sysadmin/ies-repovault.sh' do
  source 'ies-repovault-RH7.sh'
  not_if do ::File.exists?('/sysadmin/ies-repovault-applied-1.1') end
end
else
template '/sysadmin/ies-repovault.sh' do
  source 'ies-repovault.sh'
  not_if do ::File.exists?('/sysadmin/ies-repovault-applied-1.1') end
end

execute 'chmod +x /sysadmin/ies-repovault.sh' do
not_if do ::File.exists?('/sysadmin/ies-repovault-applied-1.1') end
end

execute '/sysadmin/ies-repovault.sh' do
not_if do ::File.exists?('/sysadmin/ies-repovault-applied-1.1') end
end
# Change the following line to increment the version number of the ies-repovault script. 
file '/sysadmin/ies-repovault-applied-1.1' do
owner 'root'
group 'root'
mode '0755'
action :create
end

execute 'yum update -y' do
not_if do ::File.exists?('/sysadmin/yum-update-norun') end
end

file '/sysadmin/yum-update-norun' do
owner 'root'
group 'root'
mode '0755'
action :create
end
end