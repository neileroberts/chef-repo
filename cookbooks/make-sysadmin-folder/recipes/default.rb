#
# Cookbook Name:: make-sysadmin-folder
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