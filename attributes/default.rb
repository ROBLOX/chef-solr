include_attribute 'jetty'
include_attribute 'java'

expand!

default['solr']['version'] = '4.4.0'
default['solr']['checksum'] = nil #sha265

if node['solr']['version'].split('.')[0].to_i >= 4 && node['solr']['version'].split('.')[1].to_i >= 1
  default['solr']['url'] = "http://www.mirrorservice.org/sites/ftp.apache.org/lucene/solr/#{solr.version}/solr-#{solr.version}.tgz"
else
  default['solr']['url'] = "http://archive.apache.org/dist/lucene/solr/#{node['solr']['version']}/apache-solr-#{node['solr']['version']}.tgz"
end

default['solr']['war'] = "solr-#{node['solr']['version']}.war"

default['solr']['context_path']  = '/solr'
default['solr']['config_dir'] = '/etc/solr'
default['solr']['data'] = "#{node['jetty']['webapp_dir']}/solr/data"

default['solr']['custom_config'] = nil
default['solr']['custom_lib'] = nil
