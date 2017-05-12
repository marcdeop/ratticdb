# Module to install ratticdb
#
# By default, this module will try to install everything that is needed to
# setup a ratticdb application.
#
# This means that by default Apache httpd and Mysql will be installed
#
# The webserver will take care of redirecting the http traffic to https
# @summary This module installs ratticdb and its dependencies
#
# @author Marc Deop <marc@marcdeop.com>
#
# @see https://github.com/tildaslash/RatticWeb
#
# @see https://github.com/tildaslash/RatticWeb/wiki
#
# @example Declaring the class
#   include ratticdb
#
# @example Specifying the url to listen to
#  class { '::ratticdb':
#    url => 'xenial.example.org'
#  }
#
# @example Do not install apache, we will handle the webserver elsewhere
#  class { '::ratticdb':
#    apache => false
#  }
#
# @example Do not install mysql, we will handle the database elsewhere
#  class { '::ratticdb':
#    mysql => false
#  }
#
# @param app_folder Specifies where to install ratticdb
# @param apache Whether to install apache or not
# @param mysql Whether to install mysql or not
# @param url Url to listen to
# @param version ratticdb version to install
# @param ldap Whether to enable ldap or not
# @param ldap_server Address of the ldap server
# @param user_base Where the users are located on the ldap server
# @param user_filter Which field is used to identify users on the ldap server
# @param group_base Where the groups are located on the ldap server
# @param group_filter Which field is used to identify groups on the ldap server
# @param group_type Defines the type of group that ratticdb will read
# @param staff Group that is considered ratticdb admin on the ldap server
# @param db_name Database name that ratticdb will use
# @param db_user Username that ratticdb will use when connecting to db_name
# @param db_user_pwd Password of db_user
# @param db_host Host where the database is
# @param db_port Port where the database listens to
# @param ssl_cert_path Path where the the SSL cert is located
# @param ssl_cert_key_path Path where the SSL cert key is located
# @param ssl_cert SSL certificate that we want to use
# @param ssl_key  SSL certificate private key
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

  anchor { 'ratticdb::begin': }
    -> class { 'ratticdb::packages': }
    -> class { 'ratticdb::mysql': }
    -> class { 'ratticdb::setup': }
    -> class { 'ratticdb::apache': }
  -> anchor { 'ratticdb::end': }
}
