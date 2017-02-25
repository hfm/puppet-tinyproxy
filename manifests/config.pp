class tinyproxy::config (
  Enum['file', 'absent'] $config_ensure,
){

  $config_path = $facts['os']['family'] ? {
    'Debian' => '/etc/tinyproxy.conf',
    'RedHat' => '/etc/tinyproxy/tinyproxy.conf',
    default  => '/etc/tinyproxy/tinyproxy.conf',
  }

  $tinyproxy_user = $facts['os']['family'] ? {
    'Debian' => 'nobody',
    'RedHat' => 'tinyproxy',
    default  => 'tinyproxy',
  }

  $tinyproxy_group = $facts['os']['family'] ? {
    'Debian' => 'nogroup',
    'RedHat' => 'tinyproxy',
    default  => 'tinyproxy',
  }

  file { $config_path:
    ensure  => $config_ensure,
    content => template('tinyproxy/tinyproxy.conf.erb'),
  }

}
