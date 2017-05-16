# Puppet Classes
## ratticdb
### Source code
[manifests/init.pp](manifests/init.pp)

### Inherits from
::ratticdb::params

### Summary
This module installs ratticdb and its dependencies

### Overview
Module to install ratticdb

By default, this module will try to install everything that is needed to
setup a ratticdb application.

This means that by default Apache httpd and Mysql will be installed

The webserver will take care of redirecting the http traffic to https

#### Declaring the class
```
include ratticdb
```
#### Specifying the url to listen to
```
class { '::ratticdb':
  url => 'xenial.example.org'
}
```
#### Do not install apache, we will handle the webserver elsewhere
```
class { '::ratticdb':
  apache => false
}
```
#### Do not install mysql, we will handle the database elsewhere
```
class { '::ratticdb':
  mysql => false
}
```
### Parameters
| Name | Description | Default |
| --- | --- | --- |
| app_folder | Specifies where to install ratticdb | '/opt/apps/RatticWeb' |
| apache | Whether to install apache or not | true |
| mysql | Whether to install mysql or not | true |
| url | Url to listen to | 'ratticdb.example.org' |
| version | ratticdb version to install | '1.3.1' |
| ldap | Whether to enable ldap or not | false |
| ldap_server | Address of the ldap server | 'ldap.example.org' |
| user_base | Where the users are located on the ldap server | 'ou=users,dc=example,dc=com' |
| user_filter | Which field is used to identify users on the ldap server | '(uid=%(user)s)' |
| group_base | Where the groups are located on the ldap server | 'ou=django,ou=groups,dc=example,dc=com' |
| group_filter | Which field is used to identify groups on the ldap server | '(objectClass=groupOfNames)' |
| group_type | Defines the type of group that ratticdb will read | 'GroupOfNamesType' |
| staff | Group that is considered ratticdb admin on the ldap server | 'cn=staff,ou=groups,dc=example,dc=com' |
| db_name | Database name that ratticdb will use | 'ratticdb' |
| db_user | Username that ratticdb will use when connecting to db_name | 'ratticDbUser' |
| db_user_pwd | Password of db_user | 'ratticDbUserPassword' |
| db_host | Host where the database is | 'localhost' |
| db_port | Port where the database listens to | '3306' |
| ssl_cert_path | Path where the the SSL cert is located | $::ratticdb::params::ssl_cert_path |
| ssl_cert_key_path | Path where the SSL cert key is located | $::ratticdb::params::ssl_cert_key_path |
| ssl_cert | SSL certificate that we want to use | undef |
| ssl_key | SSL certificate private key | undef |

### See
[https://github.com/tildaslash/RatticWeb](https://github.com/tildaslash/RatticWeb)

[https://github.com/tildaslash/RatticWeb/wiki](https://github.com/tildaslash/RatticWeb/wiki)


### Authors
Marc Deop <marc@marcdeop.com>

## ratticdb::apache
### Source code
[manifests/apache.pp](manifests/apache.pp)

### Summary
This will take care of installing and configuring httpd

### Overview
This classed is not supposed to be called externally.

## ratticdb::mysql
### Source code
[manifests/mysql.pp](manifests/mysql.pp)

### Summary
This will take care of installing and configuring mysql

### Overview
This classed is not supposed to be called externally.

## ratticdb::packages
### Source code
[manifests/packages.pp](manifests/packages.pp)

### Summary
Takes care of installing all dependencies that ratticdb requires

### Overview
This classed is not supposed to be called externally.

## ratticdb::params
### Source code
[manifests/params.pp](manifests/params.pp)

### Summary
Defines parameters for the different supported Operating Systems

### Overview
This classed is not supposed to be called externally.

## ratticdb::setup
### Source code
[manifests/setup.pp](manifests/setup.pp)

### Summary
Installs and configures ratticdb

### Overview
This classed is not supposed to be called externally.

