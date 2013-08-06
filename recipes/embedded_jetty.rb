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

group node['jetty']['group'] do
  action :create
end

user node['jetty']['user'] do
  gid node['jetty']['group']
  action :create
end

directory '/etc/jetty6' do
  owner 'root'
  group 'root'
  mode 00644
  action :create
end

execute 'ln -s solr/example jetty6' do
  command 'ln -sf /usr/local/solr/example /usr/share/jetty6'
end

execute 'ln -s jetty.xml' do
  command 'ln -sf /usr/local/solr/example/etc/jetty.xml /etc/jetty6/jetty.xml'
end

execute 'ln-s webdefault.xml' do
  command 'ln -sf /usr/local/solr/example/etc/webdefault.xml /etc/jetty6/webdefault.xml'
end

directory '/var/run/jetty6' do
  owner node['jetty']['user']
  group node['jetty']['group']
  mode 00644
  action :create
end

cookbook_file '/usr/sbin/djetty6' do
  source 'djetty6'
  owner 'root'
  group 'root'
  mode 00755
end

cookbook_file '/etc/init.d/jetty6' do
  source 'jetty6'
  owner 'root'
  group 'root'
  mode 00755
end

template '/etc/default/jetty6' do
  source 'jetty6.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[jetty6]'
end

service 'jetty6' do
  service_name 'jetty6'
  action [:enable, :start]
  supports :status => true, :start => true, :stop => true, :restart => true
end