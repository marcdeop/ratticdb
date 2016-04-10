require 'puppetlabs_spec_helper/module_spec_helper'
RSpec.configure do |c|
  c.parser = 'future'
  c.default_facts = {
    :operatingsystem        => 'Ubuntu',
    :osfamily               => 'debian',
    :fqdn                   => 'ratticdb.example.org',
    :lsbdistid              => '7',
    :operatingsystemrelease => '23',
  }
  c.after(:suite) do
#    RSpec::Puppet::Coverage.report!(95)
    RSpec::Puppet::Coverage.report!
  end
end
