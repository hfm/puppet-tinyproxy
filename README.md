# tinyproxy [![Build Status](https://travis-ci.org/hfm/puppet-tinyproxy.svg?branch=master)](https://travis-ci.org/hfm/puppet-tinyproxy) [![Puppet Forge](https://img.shields.io/puppetforge/v/hfm/tinyproxy.svg?style=flat-square)](https://forge.puppet.com/hfm/tinyproxy)

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with tinyproxy](#setup)
  - [Setup requirements](#setup-requirements)
  - [Beginning with tinyproxy](#beginning-with-tinyproxy)
1. [Usage - Configuration options and additional functionality](#usage)
  - [Configuring tinyproxy](#configuring-tinyproxy)
  - [Configuring modules from Hiera](#configuring-modules-from-hiera)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
  - [Public Classes](#public-classes)
  - [Private Classes](#private-classes)
  - [Parameters](#parameters)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)
  - [Running tests](#running-tests)
  - [Testing quickstart](#testing-quickstart)

## Description

The tinyproxy module handles installing, configuring, and running [tinyproxy](http://tinyproxy.github.io).

## Setup

### Setup Requirements

The tinyproxy module requires the following puppet modules:

- [puppetlabs-stdlib](https://forge.puppet.com/puppetlabs/stdlib) (>= 4.0.0 < 5.0.0)
- [puppetlabs-apt](https://forge.puppet.com/puppetlabs/apt) (>= 2.0.0 < 3.0.0) (only Debian-based distributions)
- [stahnma-epel](https://forge.puppet.com/stahnma/epel) (>= 1.0.0 < 2.0.0) (only RedHat-based distributions)

### Beginning with tinyproxy

To install the tinyproxy with default parameters, declare the `tinyproxy` class.

```puppet
include ::tinyproxy
```

## Usage

### Configuring tinyproxy

```puppet
class { '::tinyproxy':
  use_epel       => true,
  package_ensure => 'installed',
  config_ensure  => 'file',
  service_ensure => 'running',
  service_enable => true,
}
```

### Configuring modules from Hiera

```yaml
---
tinyproxy::use_epel: true
tinyproxy::package_ensure: installed
tinyproxy::config_ensure: file
tinyproxy::service_ensure: running
tinyproxy::service_enable: true
```
## Reference

### Public Classes

- [`tinyproxy`](#tinyproxy): Installs, configures, and runs tinyproxy.

### Private Classes

- `tinyproxy::install`: Installs the tinyproxy package.
- `tinyproxy::config`: Configures tinyproxy.conf.
- `tinyproxy::service`: Manages service.

### Parameters

#### Class: `tinyproxy`

- `use_epel`: Whether epel repository should be installed. Type is Boolean. Default: true.
- `package_ensure`: What state the tinyproxy package should be in. Type is String. Default: 'installed'.
- `config_ensure`: Whether the tinyproxy.conf should exist. Type is Enum['file', 'absent']. Default: 'file'.
- `port`:Specify the port which tinyproxy will listen on. Type is Integer. Default: 8888.
- `listen`: Allow you to bind to an interface. Type is Optional[String]. Default: undef.
- `bind`: Specify which interface will be used for outgoing connections. Type is Optional[String]. Default: undef.
- `bind_same`: Whether tinyproxy will bind the outgoing connection to the ip address of the incoming connection. Type is Optional[Boolean]. Default: undef.
- `timeout`: Specify a timeout of a connection. Type is Integer. Default: 600.
- `error_files`: Specify the HTML file to send when a given HTTP error occurs. Type is Optional[Hash[Integer, String]]. Default: undef.
- `default_error_file`: Specify the default Error HTML file. Type is String. Default: '/usr/share/tinyproxy/default.html'.
- `stat_host`: Specify the stat host. Type is Optional[String]. Default: undef.
- `stat_file`: Specify the HTML file for the stat host. Type is String. Default: '/usr/share/tinyproxy/stats.html'.
- `log_file`: Specify the log file. Type is Optional[String]. Default: '/var/log/tinyproxy/tinyproxy.log'.
- `use_syslog`: Whether tinyproxy uses syslog instead of a log file. This parameter and `$log_file` are mutually exclusive. Type is Boolean. Default: false.
- `pid_file`: Specify the pid file. Type is String. Default: '/var/run/tinyproxy/tinyproxy.pid'.
- `max_clients`: Specify maximum number of clients can be connected at the same time. Type is Integer. Default: 100.
- `min_spare_servers`: Specify the lower limit for the number of spare servers which should be available. Type is Integer. Default: 5.
- `max_spare_servers`: Specify the upper limit for the number of spare servers which should be available. Type is Integer. Default: 20.
- `start_servers`: Specify the number of servers to start initially. Type is Integer. Default: 10.
- `max_requests_per_child`: Specify the number of connections a thread will handle before it's killed. Type is Integer. Default: 0.
- `log_level`: Set the logging level. Type is Enum['Critical', 'Error', 'Warning', 'Notice', 'Connect', 'Info']. Default: 'Info'.
- `connect_port`: Specify a list of ports allowed by tinyproxy when the CONNECT method is used. Type is Variant[Integer, Array[Integer]]. Default: [443, 563].
- `service_ensure`: Whether a service should be running. Type is Enum['running', 'stopped']. Default: 'running'.
- `service_enable`: Whether a service should be enabled to start at boot. Type is Boolean. Default: true.

## Limitations

This module has been tested on:

- RedHat Enterprise Linux 7
- CentOS 7
- Scientific Linux 7
- Debian 8
- Ubuntu 16.04

## Development

### Running tests

The tinyproxy module contains tests for both [rspec-puppet](http://rspec-puppet.com/) (unit tests) and [beaker-rspec](https://github.com/puppetlabs/beaker-rspec) (acceptance tests) to verify functionality. For detailed information on using these tools, please see their respective documentation.

#### Testing quickstart

- Unit tests:

```console
$ bundle install
$ bundle exec rake test
```

- Acceptance tests using docker:

```console
# List available beaker nodesets
$ bundle exec rake beaker_nodes
centos7
jessie
xenial

# Run beaker acceptance tests
$ BEAKER_set=centos7 bundle exec rake beaker
```
