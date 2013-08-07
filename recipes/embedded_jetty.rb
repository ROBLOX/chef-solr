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

directory '/etc/jetty6' do
  owner 'root'
  group 'root'
  mode 00644
  action :create
end

link '/usr/share/jetty6' do
  to '/usr/local/solr/example'
end

link '/etc/jetty6/jetty.xml' do
  to '/usr/local/solr/example/etc/jetty.xml'
end

link '/etc/jetty6/webdefault.xml' do
  to '/usr/local/solr/example/etc/webdefault.xml'
end

directory '/var/run/jetty6' do
  owner node['jetty']['user']
  group node['jetty']['group']
  mode 00644
  action :create
end

template '/usr/sbin/djetty6' do
  source 'djetty6.erb'
  owner 'root'
  group 'root'
  mode 00755
end

template '/etc/init.d/jetty6' do
  source 'jetty6.erb'
  owner 'root'
  group 'root'
  mode 00755
end

template '/etc/default/jetty6' do
  source 'jetty6.default.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'jetty6' do
  service_name 'jetty6'
  action [:enable, :start]
  supports :status => true,:start => true,:stop => true,:restart => true
end
