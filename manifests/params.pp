#
class ratticdb::params {
  case $::osfamily {
    'debian': {
      $managingClass  = 'apt'
      $pythonDev      = 'python-dev'
      $libxml2Dev     = 'libxml2-dev'
      $libxslt1Dev    = 'libxslt1-dev'
      $mysqlDev       = 'libmysqlclient-dev'
      $sslDev         = 'libssl-dev'
      $libldap2Dev    = 'libldap2-dev'
      $libsasl2Dev    = 'libsasl2-dev'
      $sslCertPath    = '/etc/ssl/certs/ssl-cert-snakeoil.pem'
      $sslCertKeyPath = '/etc/ssl/private/ssl-cert-snakeoil.key'
    }
    'redhat': {
      $managingClass  = 'epel'
      $pythonDev      = 'python-devel'
      $libxml2Dev     = 'libxml2-devel'
      $libxslt1Dev    = 'libxslt-devel'
      $mysqlDev       = 'mariadb-devel'
      $sslDev         = 'openssl-devel'
      $libldap2Dev    = 'openldap-devel'
      $libsasl2Dev    = 'cyrus-sasl-devel'
      $sslCertPath    = '/etc/ssl/certs/localhost.crt'
      $sslCertKeyPath = '/etc/pki/tls/private/localhost.key'
    }
  default: {
      fail('Operating system not supported')
    }
  }
}
