# This classed is not supposed to be called externally.
# @summary This will take care of installing and configuring httpd
class ratticdb::apache {
  if $::ratticdb::apache {
    class { '::apache':
        default_vhost => false,
    }

    apache::vhost {"redirect-${::ratticdb::url}":
      servername      => $::ratticdb::url,
      port            => '80',
      docroot         => $::ratticdb::app_folder,
      redirect_status => 'permanent',
      redirect_dest   => "https://${::ratticdb::url}",
      manage_docroot  => false,
    }

    if $::ratticdb::ssl_cert != undef {
      file { $::ratticdb::ssl_cert_path:
        content => $::ratticdb::ssl_cert,
      }
      file { $::ratticdb::ssl_cert_key_path:
        content => $::ratticdb::ssl_key,
      }
    }

    apache::vhost { $::ratticdb::url:
      port                        => '443',
      ssl                         => true,
      ssl_honorcipherorder        => 'on',
      ssl_cert                    => $::ratticdb::ssl_cert_path,
      ssl_key                     => $::ratticdb::ssl_cert_key_path,
      docroot                     => $::ratticdb::app_folder,
      manage_docroot              => false,
      wsgi_application_group      => '%{GLOBAL}',
      wsgi_daemon_process         => 'rattic',
      wsgi_daemon_process_options => {
        processes    => '2',
        threads      => '25',
        display-name => '%{GROUP}',
        home         => $::ratticdb::app_folder,
        python-path  => $::ratticdb::app_folder
      },
      wsgi_pass_authorization     => 'on',
      wsgi_process_group          => 'rattic',
      wsgi_script_aliases         => {
        '/' => "${::ratticdb::app_folder}/ratticweb/wsgi.py"
      },
      aliases                     => [
        {
          aliasmatch => '^/([^/]*\.css)',
          path       => '/opt/apps/RatticWeb/static/styles/$1',
        },
        {
          alias => '/favicon.ico',
          path  => "${::ratticdb::app_folder}/static/favicon.ico",
        },
        {
          alias => '/robots.txt',
          path  => "${::ratticdb::app_folder}/static/robots.txt",
        },
        {
          alias => '/media',
          path  => "${::ratticdb::app_folder}/media",
        },
        {
          alias => '/static',
          path  => "${::ratticdb::app_folder}/static",
        },
      ],
    }
  }

}
