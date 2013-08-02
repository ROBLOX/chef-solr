include_attribute "jetty"

expand!

default['solr']['version']       = "4.4.0"
default['solr']['directory']     = "#{Chef::Config['file_cache_path']}"
default['solr']['checksum']      = "4852e866f77ba2e4dc1639610316a64d384531d00d7e8963e0984ad11e6d2b5a" #sha265

if solr.version.split('.').first.to_i >= 4 && solr.version.split('.').second.to_i >= 1
  default['solr']['url']         = "http://www.mirrorservice.org/sites/ftp.apache.org/lucene/solr/#{solr.version}/solr-#{solr.version}.tgz"
  set['solr']['ver']             = "solr-#{node['solr']['version']}"
else
  default['solr']['url']         = "http://archive.apache.org/dist/lucene/solr/#{node['solr']['version']}/apache-solr-#{node['solr']['version']}.tgz"
  set['solr']['ver']             = "apache-solr-#{node['solr']['version']}"
end

default['solr']['download']      = ::File.join node['solr']['directory'],"#{node['solr']['ver']}.tgz"
default['solr']['extracted']     = ::File.join node['solr']['directory'],node['solr']['ver']
default['solr']['war']           = ::File.join node['solr']['extracted'],'dist',"#{node['solr']['ver']}.war"

default['solr']['context_path']  = 'solr'
default['solr']['home']          = ::File.join 'etc','solr'
set['solr']['config']            = ::File.join node['solr']['home'],'conf'
set['solr']['lib']               = ::File.join node['solr']['home'],'lib'
default['solr']['data']          = ::File.join node['jetty']['home'],'webapps',node['solr']['context_path'],'data'
default['solr']['custom_config'] = nil
default['solr']['custom_lib']    = nil
