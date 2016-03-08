#
# Cookbook Name:: wrapper_test
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

application 'testapp' do
  repository 'http://<url>/testapp.war'
  path '/path/on/disk'
  tomcat
end
