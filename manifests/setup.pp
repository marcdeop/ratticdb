#
class ratticdb::setup {
  $url       = $::ratticdb::url
  $appFolder = $::ratticdb::appFolder
  $ldap      = $::ratticdb::ldap
  $dbName    = $::ratticdb::dbName
  $dbUser    = $::ratticdb::dbUser
  $dbUserPwd = $::ratticdb::dbUserPwd
  $dbHost    = $::ratticdb::dbHost
  $dbPort    = $::ratticdb::dbPort
  $version   = $::ratticdb::version

  $baseDir = dirname($appFolder)

  $dirTree = dirtree($baseDir)
  ensure_resource('file', $dirTree, {'ensure' => 'directory'})

  exec { 'wget' :
    command => "wget https://github.com/tildaslash/RatticWeb/archive/v${version}.tar.gz",
    cwd     => $baseDir,
    creates => "${baseDir}/v${version}.tar.gz",
    path    => '/usr/bin/',
    require => File[$baseDir],
    onlyif  => "test ! -e ${appFolder}-${version}"
  }

  exec { 'extract' :
    command => "tar -zxvf v${version}.tar.gz",
    cwd     => '/opt/apps',
    creates => "/opt/apps/RatticWeb-${version}",
    path    => '/usr/bin/:/bin/',
    require => Exec['wget'],
  }

  file {'link':
    ensure  => 'link',
    path    => $appFolder,
    target  => "${appFolder}-${version}",
    require => Exec['extract'],
  }

  file { 'confFile':
    ensure  => 'file',
    path    => "${appFolder}/conf/local.cfg",
    content => template('ratticdb/local.cfg.erb'),
    require => File['link'],
  }

  file { "${appFolder}/static" :
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0775',
    require => File['link'],
  }

  exec { 'setup':
    command     => "manage.py syncdb --noinput && manage.py migrate \
      && manage.py collectstatic --noinput && manage.py compilemessages",
    cwd         => $appFolder,
    path        => "/usr/bin/:/bin/:${appFolder}",
    require     => File['confFile'],
    subscribe   => File['confFile'],
    refreshonly => true,
  }
}
