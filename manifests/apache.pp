#
class ratticdb::apache {
  if $::ratticdb::apache {
    class { '::apache':
        default_vhost => false,
    }

    apache::vhost {"redirect-${::ratticdb::url}":
      servername      => $::ratticdb::url,
      port            => '80',
      docroot         => $::ratticdb::appFolder,
      redirect_status => 'permanent',
      redirect_dest   => "https://${::ratticdb::url}",
      manage_docroot  => false,
    }

    if $::ratticdb::sslCert != undef {
      file { $::ratticdb::sslCertPath:
        content => $::ratticdb::sslCert,
      }
      file { $::ratticdb::sslCertKeyPath:
        content => $::ratticdb::sslKeyCert,
      }
    }

    apache::vhost { $::ratticdb::url:
      port                        => '443',
      ssl                         => true,
      ssl_honorcipherorder        => 'on',
      ssl_cert                    => $::ratticdb::sslCertPath,
      ssl_key                     => $::ratticdb::sslCertKeyPath,
      docroot                     => $::ratticdb::appFolder,
      manage_docroot              => false,
      wsgi_application_group      => '%{GLOBAL}',
      wsgi_daemon_process         => 'rattic',
      wsgi_daemon_process_options => {
        processes    => '2',
        threads      => '25',
        display-name => '%{GROUP}',
        home         => $::ratticdb::appFolder,
        python-path  => $::ratticdb::appFolder
      },
      wsgi_pass_authorization     => 'on',
      wsgi_process_group          => 'rattic',
      wsgi_script_aliases         => {
        '/' => "${::ratticdb::appFolder}/ratticweb/wsgi.py"
      },
      aliases                     => [
        {
          aliasmatch => '^/([^/]*\.css)',
          path       => '/opt/apps/RatticWeb/static/styles/$1',
        },
        {
          alias => '/favicon.ico',
          path  => "${::ratticdb::appFolder}/static/favicon.ico",
        },
        {
          alias => '/robots.txt',
          path  => "${::ratticdb::appFolder}/static/robots.txt",
        },
        {
          alias => '/media',
          path  => "${::ratticdb::appFolder}/media",
        },
        {
          alias => '/static',
          path  => "${::ratticdb::appFolder}/static",
        },
      ],
    }
  }

}
