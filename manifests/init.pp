# Class: tinyproxy
# ===========================
#
# Full description of class tinyproxy here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'tinyproxy':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class tinyproxy (
  Boolean                   $use_epel       = true,
  String                    $package_ensure = 'installed',

  Enum['file', 'absent']    $config_ensure  = 'file',
  Integer $port = 8888,
  String $listen = '',
  String $bind = '',
  Boolean $bind_same = true,
  Integer $timeout = 600,
  Integer $max_clients = 100,
  Integer $min_space_servers = 5,
  Integer $max_space_servers = 20,
  Integer $start_servers = 10,
  Integer $max_requests_per_child = 0,
  Enum['Critical', 'Error', 'Warning', 'Notice', 'Connect', 'Info'] $log_level = 'Info',

  Enum['running','stopped'] $service_ensure = 'running',
  Boolean                   $service_enable = true,
){

  class { 'tinyproxy::install':
    use_epel       => $use_epel,
    package_ensure => $package_ensure,
  } ->

  class { 'tinyproxy::config':
    config_ensure => $config_ensure,
  } ~>

  class { 'tinyproxy::service':
    service_ensure => $service_ensure,
    service_enable => $service_enable,
  }

}
