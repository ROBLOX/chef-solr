include_attribute "jetty"

expand!

default['solr']['version']       = "4.4.0"
default['solr']['checksum']      = "4852e866f77ba2e4dc1639610316a64d384531d00d7e8963e0984ad11e6d2b5a" #sha265

if node['solr']['version'].split('.')[0].to_i >= 4 && node['solr']['version'].split('.')[1].to_i >= 1
  default['solr']['url']         = "http://www.mirrorservice.org/sites/ftp.apache.org/lucene/solr/#{solr.version}/solr-#{solr.version}.tgz"
else
  default['solr']['url']         = "http://archive.apache.org/dist/lucene/solr/#{node['solr']['version']}/apache-solr-#{node['solr']['version']}.tgz"
end

default['solr']['config_dir']    = '/etc/solr'
default['solr']['data']          = "#{node['jetty']['home']}/#{node["jetty"]["webapp_dir"]}/solr/data"
default['solr']['custom_config'] = nil
default['solr']['custom_lib']    = nil
