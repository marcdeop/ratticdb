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
  $appFolder      = '/opt/apps/RatticWeb',
  $apache         = true,
  $mysql          = true,
  $url            = 'ratticdb.example.org',
  $version        = '1.3.1',
  $ldap           = false,
  $ldapServer     = 'ldap.example.org',
  $userBase       = 'ou=users,dc=example,dc=com',
  $userFilter     = '(uid=%(user)s)',
  $groupBase      = 'ou=django,ou=groups,dc=example,dc=com',
  $groupFilter    = '(objectClass=groupOfNames)',
  $groupType      = 'GroupOfNamesType',
  $staff          = 'cn=staff,ou=groups,dc=example,dc=com',
  $dbName         = 'ratticdb',
  $dbUser         = 'ratticDbUser',
  $dbUserPwd      = 'ratticDbUserPassword',
  $dbHost         = 'localhost',
  $dbPort         = '3306',
  $sslCertPath    = $::ratticdb::params::sslCertPath,
  $sslCertKeyPath = $::ratticdb::params::sslCertKeyPath,
  $sslCert        = undef,
  $sslKey         = undef,
  ) inherits ::ratticdb::params {

  if !is_integer($dbPort) {
    fail('dbPort must be a valid integer')
  }

  if !is_string($dbUser) {
    fail('dbUser must be a valid string')
  }

  if !is_string($dbName) {
    fail('dbName must be a valid string')
  }

  if !is_string($dbUserPwd) {
    fail('dbUserPwd must be a valid string')
  }

  if !is_domain_name($dbHost) {
    fail('dbHost must be a valid domain name')
  }

  if !is_bool($ldap) {
    fail('ldap must be a boolean')
  }

  if !is_domain_name($ldapServer) {
    fail('ldapServer must be a valid domain name')
  }

  if !is_string($userBase) {
    fail('userBase must be a valid string')
  }

  if !is_string($userFilter) {
    fail('userFilter must be a valid string')
  }

  if !is_string($groupBase) {
    fail('groupBase must be a valid string')
  }

  if !is_string($groupFilter) {
    fail('groupFilter must be a valid string')
  }

  if !is_string($groupType) {
    fail('groupType must be a valid string')
  }

  if !is_domain_name($url) {
    fail('url must be a valid domain name')
  }

  if !is_absolute_path($appFolder) {
    fail('appFolder must be an absolute path')
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
