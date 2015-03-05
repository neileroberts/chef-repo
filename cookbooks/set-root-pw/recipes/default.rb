#
# Cookbook Name:: set-root-pw
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
password_hash = 'MAD@w0rk'

user "Setting root password" do
    username 'root'
    password password_hash
    action :modify
  end