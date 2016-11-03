require 'spec_helper'
describe 'ratticdb' do

  context 'with defaults for all parameters' do
    it { should contain_anchor('ratticdb::begin') }
    it { should contain_anchor('ratticdb::end') }
    it { should contain_class('ratticdb') }
    it { should contain_class('ratticdb::packages') }
    it { should contain_class('ratticdb::mysql') }
    it { should contain_class('ratticdb::apache') }
    it { should contain_class('ratticdb::setup') }
    it { should contain_class('mysql::server') }
    it { should contain_Exec('forceUpdatePackages') }
    it { should contain_Mysql_user('ratticDbUser@localhost') }
    it { should contain_Mysql_database('ratticdb') }
    it { should contain_Mysql__Db('ratticdb') }
    it { should contain_Apache__Listen('80') }
    it { should contain_Apache__Vhost('ratticdb.example.org') }
    it { should contain_Exec('updatePackages') }
    it { should contain_file('/opt').with_ensure('directory') }
    it { should contain_file('/opt/apps').with_ensure('directory') }
    it { should contain_file('/opt/apps/RatticWeb/static').with(
      'ensure' => 'directory',
    )}
    it { should contain_exec('extract') }
    it { should contain_exec('wget') }
    it { should contain_exec('setup') }
    it { should contain_file('link').with_ensure('link') }
    it { should contain_file('confFile').with(
      'ensure' => 'file',
      :content => /^debug = False\n/,
    )}
# ToDo: check path to static folder in configuration!
#    it { should contain_file('/opt/apps/RatticWeb/conf/local.cfg').with(
#        :content => /^static = /opt/apps/RatticWeb/static/\n/,
#    )}
    it { should contain_file('confFile').with(
      :content => /^hostname = ratticdb.example.org\n/,
    )}
    it { should contain_file('confFile').with(
      :content => /^engine = django.db.backends.mysql\n/,
    )}
    it { should contain_file('confFile').with(
      :content => /^engine = django.db.backends.mysql\n/,
    )}
    it { should contain_Apache__Listen('443') }
    it { should contain_Apache__Vhost('redirect-ratticdb.example.org') }
    it { should contain_Class('Ratticdb::Params') }

  end

  context 'appFolder => wrongPath' do
    let(:params) { {:appFolder => 'This is a wrong path' } }
    it do
      is_expected.to raise_error(/appFolder must be an absolute path/)
    end
  end

  context 'apache => wrongValue' do
    let(:params) { {:apache => 'wrongValue' } }
    it do
      is_expected.to raise_error(/apache must be a boolean/)
    end
  end

  context 'mysql => wrongValue' do
    let(:params) { {:mysql => 'wrongValue' } }
    it do
      is_expected.to raise_error(/mysql must be a boolean/)
    end
  end

  context 'url => wrong Domain' do
    let(:params) { {:url => 'wrong Domain' } }
    it do
      is_expected.to raise_error(/url must be a valid domain name/)
    end
  end

  context 'ldap => wrongValue' do
    let(:params) { {:ldap => 'wronValue' } }
    it do
      is_expected.to raise_error(/ldap must be a boolean/)
    end
  end

  context 'ldapServer => wrong Domain' do
    let(:params) { {:ldapServer => 'wrong Domain' } }
    it do
      is_expected.to raise_error(/ldapServer must be a valid domain name/)
    end
  end

  context 'userBase => wrong userBase' do
    let(:params) { {:userBase => :undef } }
    it do
      is_expected.to raise_error(/userBase must be a valid string/)
    end
  end

  context 'userFilter => wrong userFilter' do
    let(:params) { {:userFilter => nil } }
    it do
      is_expected.to raise_error(/userFilter must be a valid string/)
    end
  end

  context 'groupBase => wrong groupbase' do
    let(:params) { {:groupBase => nil } }
    it do
      is_expected.to raise_error(/groupBase must be a valid string/)
    end
  end

  context 'groupFilter => wrong groupFilter' do
    let(:params) { {:groupFilter => nil } }
    it do
      is_expected.to raise_error(/groupFilter must be a valid string/)
    end
  end

  context 'groupType => wrong groupType' do
    let(:params) { {:groupType => nil } }
    it do
      is_expected.to raise_error(/groupType must be a valid string/)
    end
  end

  context 'staff => wrong staff' do
    let(:params) { {:staff => nil } }
    it do
      is_expected.to raise_error(/staff must be a valid string/)
    end
  end

end
