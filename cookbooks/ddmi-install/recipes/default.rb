#
# Cookbook Name:: ddmi-install
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute 'wget ftp://gbh-neil-lx/pub/hp*' do
cwd '/sysadmin'
not_if do ::File.exists?('/sysadmin/hp-ud-agent-10.11.000-2.i386.rpm') end
end

execute 'yum -y install /sysadmin/hp-ud-agent-10.11.000-2.i386.rpm' do
not_if do ::File.exists?('/sysadmin/hp-ud-agent-10.11.000-2.i386.installed') end
end

file '/sysadmin/hp-ud-agent-10.11.000-2.i386.installed' do
owner 'root'
group 'root'
mode '0755'
action :create
end