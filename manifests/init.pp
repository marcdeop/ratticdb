# == Class: ratticdb
#
# Full description of class ratticdb here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'ratticdb':
#    mysql => false,
#  }
#
# === Authors
#
# Marc Deop <marc@marcdeop.com>
#
# === Copyright
#
# Copyright 2016 Marc Deop, unless otherwise noted.
#
class ratticdb (
  $app_folder        = '/opt/apps/RatticWeb',
  $apache            = true,
  $mysql             = true,
  $url               = 'ratticdb.example.org',
  $version           = '1.3.1',
  $ldap              = false,
  $ldap_server       = 'ldap.example.org',
  $user_base         = 'ou=users,dc=example,dc=com',
  $user_filter       = '(uid=%(user)s)',
  $group_base        = 'ou=django,ou=groups,dc=example,dc=com',
  $group_filter      = '(objectClass=groupOfNames)',
  $group_type        = 'GroupOfNamesType',
  $staff             = 'cn=staff,ou=groups,dc=example,dc=com',
  $db_name           = 'ratticdb',
  $db_user           = 'ratticDbUser',
  $db_user_pwd       = 'ratticDbUserPassword',
  $db_host           = 'localhost',
  $db_port           = '3306',
  $ssl_cert_path     = $::ratticdb::params::ssl_cert_path,
  $ssl_cert_key_path = $::ratticdb::params::ssl_cert_key_path,
  $ssl_cert          = undef,
  $ssl_key           = undef,
  ) inherits ::ratticdb::params {

  if !is_integer($db_port) {
    fail('db_port must be a valid integer')
  }

  if !is_string($db_user) {
    fail('db_user must be a valid string')
  }

  if !is_string($db_name) {
    fail('db_name must be a valid string')
  }

  if !is_string($db_user_pwd) {
    fail('db_user_pwd must be a valid string')
  }

  if !is_domain_name($db_host) {
    fail('db_host must be a valid domain name')
  }

  if !is_bool($ldap) {
    fail('ldap must be a boolean')
  }

  if !is_domain_name($ldap_server) {
    fail('ldap_server must be a valid domain name')
  }

  if !is_string($user_base) {
    fail('user_base must be a valid string')
  }

  if !is_string($user_filter) {
    fail('user_filter must be a valid string')
  }

  if !is_string($group_base) {
    fail('group_base must be a valid string')
  }

  if !is_string($group_filter) {
    fail('group_filter must be a valid string')
  }

  if !is_string($group_type) {
    fail('group_type must be a valid string')
  }

  if !is_string($staff) {
    fail('staff must be a valid string')
  }

  if !is_domain_name($url) {
    fail('url must be a valid domain name')
  }

  if !is_absolute_path($app_folder) {
    fail('app_folder must be an absolute path')
  }

  if !is_bool($mysql) {
    fail('mysql must be a boolean')
  }

  if !is_bool($apache) {
    fail('apache must be a boolean')
  }

  anchor { 'ratticdb::begin': } ->
    class { 'ratticdb::packages': } ->
    class { 'ratticdb::mysql': } ->
    class { 'ratticdb::setup': } ->
    class { 'ratticdb::apache': } ->
  anchor { 'ratticdb::end': }
}
