require 'spec_helper'
describe 'ratticdb::packages' do

  context 'with defaults for all parameters' do
    it { should contain_class('ratticdb::packages') }
    it { should contain_package('python') }
    it { should contain_package('python-pip') }
    it { should contain_package('python-dev') }
    it { should contain_package('libxml2-dev') }
    it { should contain_package('libxslt1-dev') }
    it { should contain_package('gcc') }
    it { should contain_package('libmysqlclient-dev') }
    it { should contain_package('libssl-dev') }
    it { should contain_package('libldap2-dev') }
    it { should contain_package('libsasl2-dev') }
    it { should contain_package('gettext') }
    it { should contain_package('Django').with_ensure('1.6') }
    it { should contain_package('Markdown').with_ensure('2.4') }
    it { should contain_package('MySQL-python').with_ensure('1.2.5') }
    it { should contain_package('Pillow').with_ensure('2.3.1') }
    it { should contain_package('South').with_ensure('0.8.4') }
    it { should contain_package('django-auth-ldap').with_ensure('1.1.8') }
    it { should contain_package('django-database-files').with_ensure('0.1') }
    it { should contain_package('django-otp').with_ensure('0.2.7') }
    it { should contain_package('django-tastypie').with_ensure('0.9.15') }
    it { should contain_package('django-two-factor-auth').with_ensure('0.5.0') }
    it { should contain_package('django-user-sessions').with_ensure('0.1.3') }
    it { should contain_package('mimeparse').with_ensure('0.1.3') }
    it { should contain_package('pyasn1').with_ensure('0.1.7') }
    it { should contain_package('pycrypto').with_ensure('2.6') }
    it { should contain_package('python-dateutil').with_ensure('2.1') }
    it { should contain_package('python-ldap').with_ensure('2.4.15') }
    it { should contain_package('python-mimeparse').with_ensure('0.1.4') }
    it { should contain_package('six').with_ensure('1.6.1') }
    it { should contain_package('urldecode').with_ensure('0.1') }
    it { should contain_package('wsgiref').with_ensure('0.1.2') }
    it { should contain_package('keepassdb').with_ensure('0.2.1') }
    it { should contain_package('db_backup').with_ensure('0.1.3') }
    it { should contain_package('boto').with_ensure('2.26.1') }
    it { should contain_package('lxml').with_ensure('3.3.3') }
    it { should contain_package('celery').with_ensure('3.1.11') }
    it { should contain_package('django-celery').with_ensure('3.1.10') }
    it { should contain_package('importlib').with_ensure('latest') }
    it { should contain_package('django-social-auth').with_ensure('0.7.9') }
    it { should contain_package('paramiko').with_ensure('1.15.2') }
    it { should contain_package('kombu').with_ensure('3.0.26') }
    it { should contain_package('ecdsa').with_ensure('0.13') }
  end
end

