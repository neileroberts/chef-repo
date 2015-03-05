#
# Cookbook Name:: chef-crontab
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
cron "chef-client" do 
  minute '*/30'
  command '/usr/bin/chef-client'
  action :create
end

cron "yum-update-norun" do 
  hour '6,12,18'
  command 'rm -rf /sysadmin/yum-update-norun'
  action :create
end