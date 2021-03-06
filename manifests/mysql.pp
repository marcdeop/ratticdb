# This classed is not supposed to be called externally.
# @summary This will take care of installing and configuring mysql
class ratticdb::mysql {
  case $::osfamily {
    'debian': {
      exec { 'forceUpdatePackages':
        command => 'apt-get update',
        before  => Class['::mysql::server'],
        path    => '/usr/bin/',
      }
    }
    default: { }
  }
  class { '::mysql::server':
  }

  mysql::db { $::ratticdb::db_name:
    user     => $::ratticdb::db_user,
    host     => $::ratticdb::db_host,
    password => $::ratticdb::db_user_pwd,
  }
}
