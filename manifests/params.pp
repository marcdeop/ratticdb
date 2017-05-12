#
class ratticdb::params {
  case $::osfamily {
    'debian': {
      $managing_class    = 'apt'
      $python_pip        = 'python-pip'
      $python_dev        = 'python-dev'
      $libxml2_dev       = 'libxml2-dev'
      $libxslt1_dev      = 'libxslt1-dev'
      $mysql_dev         = 'libmysqlclient-dev'
      $ssl_dev           = 'libssl-dev'
      $libldap2_dev      = 'libldap2-dev'
      $libsasl2_dev      = 'libsasl2-dev'
      $ssl_cert_path     = '/etc/ssl/certs/ssl-cert-snakeoil.pem'
      $ssl_cert_key_path = '/etc/ssl/private/ssl-cert-snakeoil.key'
    }
    'redhat': {
      $managing_class    = 'epel'
      $python_pip        = 'python2-pip'
      $python_dev        = 'python-devel'
      $libxml2_dev       = 'libxml2-devel'
      $libxslt1_dev      = 'libxslt-devel'
      $mysql_dev         = 'mariadb-devel'
      $ssl_dev           = 'openssl-devel'
      $libldap2_dev      = 'openldap-devel'
      $libsasl2_dev      = 'cyrus-sasl-devel'
      $ssl_cert_path     = '/etc/ssl/certs/localhost.crt'
      $ssl_cert_key_path = '/etc/pki/tls/private/localhost.key'
    }
  default: {
      fail('Operating system not supported')
    }
  }
}
