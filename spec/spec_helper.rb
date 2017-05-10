require 'puppetlabs_spec_helper/module_spec_helper'
base_dir = File.dirname(File.expand_path(__FILE__))

RSpec.configure do |c|
  # supply tests with a possibility to test for the future parser
  c.add_setting :puppet_future
  c.puppet_future   = Puppet.version.to_f >= 4.0
  c.module_path     = File.join(base_dir, 'fixtures', 'modules')
  c.manifest_dir    = File.join(base_dir, 'fixtures', 'manifests')
  c.manifest        = File.join(base_dir, 'fixtures', 'manifests', 'site.pp')
  c.environmentpath = File.join(Dir.pwd, 'spec')
  c.parser = 'future'
  c.default_facts = {
    operatingsystem:           'Ubuntu',
    osfamily:                  'Debian',
    fqdn:                      'ratticdb.example.org',
    lsbdistid:                 'Ubuntu',
    lsbdistcodename:           'trusty',
    lsbdistrelease:            '14.04',
    operatingsystemrelease:    '14.04',
    operatingsystemmajrelease: '14.04'
  }
  c.after(:suite) do
#    RSpec::Puppet::Coverage.report!(95)
    RSpec::Puppet::Coverage.report!
  end
end
