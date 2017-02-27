class tinyproxy::config (
  Enum['file', 'absent'] $config_ensure,
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
){

  $config_path = $facts['os']['family'] ? {
    'Debian' => '/etc/tinyproxy.conf',
    'RedHat' => '/etc/tinyproxy/tinyproxy.conf',
    default  => '/etc/tinyproxy/tinyproxy.conf',
  }

  # Template uses
  $user = $facts['os']['family'] ? {
    'Debian' => 'nobody',
    'RedHat' => 'tinyproxy',
    default  => 'tinyproxy',
  }

  $group = $facts['os']['family'] ? {
    'Debian' => 'nogroup',
    'RedHat' => 'tinyproxy',
    default  => 'tinyproxy',
  }

  file { $config_path:
    ensure  => $config_ensure,
    content => template('tinyproxy/tinyproxy.conf.erb'),
  }

}
