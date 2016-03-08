#
# Cookbook Name:: chef_workstation
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'chef-dk'
include_recipe 'python'
include_recipe 'awscli'

%w(gcc make automake autoconf curl-devel openssl-devel zlib-devel libxml2 libxml2-devel git jq).each do |p|
  yum_package p
end

execute 'install nokogiri' do
  command '/opt/chefdk/embedded/bin/gem install nokogiri -- --use-system-libraries=true --with-xml2-include=/usr/include/libxml2'
  not_if { ::File.exist? '/usr/local/workstation_configured' }
  notifies :create, 'file[/usr/local/workstation_configured]'
end

file '/usr/local/workstation_configured' do
  action :nothing
end

template '/etc/profile.d/workstation_setup.sh' do
  source 'workstation_setup.sh'
end
