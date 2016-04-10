#
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

  mysql::db { $::ratticdb::dbName:
    user     => $::ratticdb::dbUser,
    host     => $::ratticdb::dbHost,
    password => $::ratticdb::dbUserPwd,
  }
}
