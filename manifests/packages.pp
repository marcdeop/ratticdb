#
class ratticdb::packages {
  include ratticdb::params
  case $::osfamily {
    'debian': {
      include apt
      exec { 'updatePackages':
        command => 'apt-get update',
        before  => Package['python'],
        path    => '/usr/bin/',
      }
    }
    'redhat': {
      include epel
      package { 'wget':
        ensure => installed,
      }
    }
  default: {
    }
  }
  package { 'python':
    ensure  => latest,
    require => Class[$::ratticdb::params::managingClass],
  } ->
  package { $::ratticdb::params::pythonPip:
    ensure => latest,
  } ->
  package { $::ratticdb::params::pythonDev:
    ensure => latest,
  } ->
  package { $::ratticdb::params::libxml2Dev:
    ensure => latest,
  } ->
  package { $::ratticdb::params::libxslt1Dev:
    ensure => latest,
  } ->
  package { 'gcc':
    ensure => latest,
  } ->
  package { $::ratticdb::params::mysqlDev:
    ensure => latest,
  } ->
  package { $::ratticdb::params::sslDev:
    ensure => latest,
  } ->
  package { $::ratticdb::params::libldap2Dev:
    ensure => latest,
  } ->
  package { $::ratticdb::params::libsasl2Dev:
    ensure => latest,
  } ->
  package { 'gettext':
    ensure => latest,
  } ->
  package { 'Django' :
    ensure   => '1.6',
    provider => 'pip',
  } ->
  package { 'Markdown':
    ensure   => '2.4',
    provider => 'pip',
  } ->
  package { 'MySQL-python':
    ensure   => '1.2.5',
    provider => 'pip',
  } ->
  package { 'Pillow':
    ensure   => '2.3.1',
    provider => 'pip',
  } ->
  package { 'South':
    ensure   => '0.8.4',
    provider => 'pip',
  } ->
  package { 'django-auth-ldap':
    ensure   => '1.1.8',
    provider => 'pip',
  } ->
  package { 'django-database-files':
    ensure   => '0.1',
    provider => 'pip',
  } ->
  package { 'django-otp':
    ensure   => '0.2.7',
    provider => 'pip',
  } ->
  package { 'django-tastypie':
    ensure   => '0.9.15',
    provider => 'pip',
  } ->
  package { 'django-two-factor-auth':
    ensure   => '0.5.0',
    provider => 'pip',
  } ->
  package { 'django-user-sessions':
    ensure   => '0.1.3',
    provider => 'pip',
  } ->
  package { 'mimeparse':
    ensure   => '0.1.3',
    provider => 'pip',
  } ->
  package { 'pyasn1':
    ensure   => '0.1.7',
    provider => 'pip',
  } ->
  package { 'pycrypto':
    ensure   => '2.6',
    provider => 'pip',
  } ->
  package { 'python-dateutil':
    ensure   => '2.1',
    provider => 'pip',
  } ->
  package { 'python-ldap':
    ensure   => '2.4.15',
    provider => 'pip',
  } ->
  package { 'python-mimeparse':
    ensure   => '0.1.4',
    provider => 'pip',
  } ->
  package { 'six':
    ensure   => '1.6.1',
    provider => 'pip',
  } ->
  package { 'urldecode':
    ensure   => '0.1',
    provider => 'pip',
  } ->
  package { 'wsgiref':
    ensure   => '0.1.2',
    provider => 'pip',
  } ->
  package { 'keepassdb':
    ensure   => '0.2.1',
    provider => 'pip',
  } ->
  package { 'db_backup':
    ensure   => '0.1.3',
    provider => 'pip',
  } ->
  package { 'boto':
    ensure   => '2.26.1',
    provider => 'pip',
  } ->
  package { 'lxml':
    ensure   => '3.3.3',
    provider => 'pip',
  } ->
  package { 'celery':
    ensure   => '3.1.11',
    provider => 'pip',
  } ->
  package { 'django-celery':
    ensure   => '3.1.10',
    provider => 'pip',
  } ->
  package { 'importlib':
    ensure   => '1.0.4',
    provider => 'pip',
  } ->
  package { 'django-social-auth':
    ensure   => '0.7.9',
    provider => 'pip',
  } ->
  package { 'paramiko':
    ensure   => '1.15.2',
    provider => 'pip',
  } ->
  package { 'kombu':
    ensure   => '3.0.26',
    provider => 'pip',
  } ->
  package { 'ecdsa':
    ensure   => '0.13',
    provider => 'pip',
  }
}
