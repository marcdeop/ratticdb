#
class ratticdb::setup {
  $url          = $::ratticdb::url
  $app_folder   = $::ratticdb::app_folder
  $ldap         = $::ratticdb::ldap
  $db_name      = $::ratticdb::db_name
  $db_user      = $::ratticdb::db_user
  $db_user_pwd  = $::ratticdb::db_user_pwd
  $db_host      = $::ratticdb::db_host
  $db_port      = $::ratticdb::db_port
  $version      = $::ratticdb::version
  $ldap_server  = $::ratticdb::ldap_server
  $user_base    = $::ratticdb::user_base
  $user_filter  = $::ratticdb::user_filter
  $group_base   = $::ratticdb::group_base
  $group_filter = $::ratticdb::group_filter
  $group_type   = $::ratticdb::group_type
  $staff        = $::ratticdb::staff

  $base_dir = dirname($app_folder)

  $dir_tree = dirtree($base_dir)
  ensure_resource('file', $dir_tree, {'ensure' => 'directory'})

  exec { 'wget' :
    command => "wget https://github.com/tildaslash/RatticWeb/archive/v${version}.tar.gz",
    cwd     => $base_dir,
    creates => "${base_dir}/v${version}.tar.gz",
    path    => '/usr/bin/',
    require => File[$base_dir],
    onlyif  => "test ! -e ${app_folder}-${version}"
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
    path    => $app_folder,
    target  => "${app_folder}-${version}",
    require => Exec['extract'],
  }

  file { 'confFile':
    ensure  => 'file',
    path    => "${app_folder}/conf/local.cfg",
    content => template('ratticdb/local.cfg.erb'),
    require => File['link'],
  }

  file { "${app_folder}/static" :
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0775',
    require => File['link'],
  }

  exec { 'setup':
    command     => "manage.py syncdb --noinput && manage.py migrate \
      && manage.py collectstatic --noinput && manage.py compilemessages",
    cwd         => $app_folder,
    path        => "/usr/bin/:/bin/:${app_folder}",
    require     => File['confFile'],
    subscribe   => File['confFile'],
    refreshonly => true,
  }
}
