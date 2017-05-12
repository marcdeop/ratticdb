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

  context 'app_folder => wrongPath' do
    let(:params) { {:app_folder => 'This is a wrong path' } }
    it do
      is_expected.to raise_error(/app_folder must be an absolute path/)
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

  context 'ldap_server => wrong Domain' do
    let(:params) { {:ldap_server => 'wrong Domain' } }
    it do
      is_expected.to raise_error(/ldap_server must be a valid domain name/)
    end
  end

  context 'user_base => wrong user_base' do
    let(:params) { { :user_base => '123' } }
    it do
      is_expected.to raise_error(/user_base must be a valid string/)
    end
  end

  context 'user_filter => wrong user_filter' do
    let(:params) { {:user_filter => '123' } }
    it do
      is_expected.to raise_error(/user_filter must be a valid string/)
    end
  end

  context 'group_base => wrong group_base' do
    let(:params) { {:group_base => '123' } }
    it do
      is_expected.to raise_error(/group_base must be a valid string/)
    end
  end

  context 'group_filter => wrong group_filter' do
    let(:params) { {:group_filter => '123' } }
    it do
      is_expected.to raise_error(/group_filter must be a valid string/)
    end
  end

  context 'group_type => wrong group_type' do
    let(:params) { {:group_type => '123' } }
    it do
      is_expected.to raise_error(/group_type must be a valid string/)
    end
  end

  context 'staff => wrong staff' do
    let(:params) { {:staff => '123' } }
    it do
      is_expected.to raise_error(/staff must be a valid string/)
    end
  end

end
