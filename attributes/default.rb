include_attribute "jetty"

expand!

default['solr']['version']   = "4.4.0"
default['solr']['directory'] = "/usr/local/src"
default['solr']['checksum']  = "1b4552ba95c8456d4fbd596e82028eaa0619b6942786e98e1c4c31258543c708" #sha265

if solr.version.split('.').first.to_i >= 4 && solr.version.split('.').second.to_i >= 1
  default['solr']['link']      = "http://www.mirrorservice.org/sites/ftp.apache.org/lucene/solr/#{solr.version}/solr-#{solr.version}.tgz"
  solr = "solr-#{node['solr']['version']}"
  default['solr']['download']  = File.join node['solr']['directory'],"#{solr}.tgz"
  default['solr']['extracted'] = File.join node['solr']['directory'],solr
  default['solr']['war']       = File.join node['solr']['extracted'],'dist',"#{solr}.war"
else
  default['solr']['link']      = "http://archive.apache.org/dist/lucene/solr/#{node['solr']['version']}/apache-solr-#{node['solr']['version']}.tgz"
  apache_solr = "apache-solr-#{node['solr']['version']"
  default['solr']['download']  = File.join node['solr']['directory'],"#{apache_solr}.tgz"
  default['solr']['extracted'] = File.join node['solr']['directory'],apache_solr
  default['solr']['war']       = File.join node['solr']['directory'],'dist',"#{apache_solr}.war"
end


default['solr']['context_path']  = 'solr'
default['solr']['home']          = "/etc/solr"
set['solr']['config']            = File.join node['solr']['home'],'conf'
set['solr']['lib']               = File.join node['solr']['home'],'lib'
default['solr']['data']          = File.join node['jetty']['home'],'webapps',node['solr']['context_path'],'data'
default['solr']['custom_config'] = nil
default['solr']['custom_lib']    = nil
