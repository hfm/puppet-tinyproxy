class tinyproxy::config (
  Enum['file', 'absent'] $config_ensure,
  Integer $port,
  Optional[String] $listen,
  Optional[String] $bind,
  Optional[Boolean] $bind_same,
  Integer $timeout,
  Integer $max_clients,
  Integer $min_spare_servers,
  Integer $max_spare_servers,
  Integer $start_servers,
  Integer $max_requests_per_child,
  Enum['Critical', 'Error', 'Warning', 'Notice', 'Connect', 'Info'] $log_level,
  Variant[Integer, Array[Integer]] $connect_port,
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
