#
# Cookbook Name:: solr
# Recipe:: embedded_jetty
#
# Copyright 2013, Roblox Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'java'
include_recipe 'solr::common'

group node['jetty']['group'] do
  action :create
end

user node['jetty']['user'] do
  gid node['jetty']['group']
  action :create
end

link node['jetty']['home'] do
  to "#{node['ark']['prefix_home']}/solr/example"
  owner node['jetty']['user']
  group node['jetty']['group']
  mode 00644
end

link '/etc/jetty6' do
  to "#{node['ark']['prefix_home']}/solr/example/etc"
  user 'root'
  group 'root'
  mode 00755
end

directory '/var/run/jetty6' do
  owner node['jetty']['user']
  group node['jetty']['group']
  mode 00644
  recursive true
  action :create
end

directory node['jetty']['tmp_dir'] do
  owner node['jetty']['user']
  group node['jetty']['group']
  mode 00644
  recursive true
  action :create
end

directory "#{node['jetty']['log_dir']}/solr" do
  owner node['jetty']['user']
  group node['jetty']['group']
  mode 00644
  recursive true
  action :create
end

cookbook_file "#{node['ark']['prefix_home']}/solr/example/etc/jetty.conf" do
  source 'jetty.conf'
  owner node['jetty']['user']
  group node['jetty']['group']
  mode 00644
end

cookbook_file "#{node['ark']['prefix_home']}/solr/example/etc/jetty-logging.xml" do
  source 'jetty-logging.xml'
  owner node['jetty']['user']
  group node['jetty']['group']
  mode 00644
end

template "#{node['ark']['prefix_home']}/solr/example/etc/jetty.xml" do
  source 'jetty.xml.erb'
  owner node['jetty']['user']
  group node['jetty']['group']
  mode 00644
end

template "#{node['ark']['prefix_home']}/solr/example/etc/webdefault.xml" do
  source 'webdefault.xml.erb'
  owner node['jetty']['user']
  group node['jetty']['group']
  mode 00644
end

template '/usr/sbin/djetty6' do
  source 'djetty6.erb'
  owner 'root'
  group 'root'
  mode 00755
end

template '/etc/init.d/jetty6' do
  source 'jetty6'
  owner 'root'
  group 'root'
  mode 00755
end

template '/etc/sysconfig/jetty6' do
  source 'jetty6.sysconfig.erb'
  owner 'root'
  group 'root'
  mode 00644
end

service 'jetty6' do
  service_name 'jetty6'
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
