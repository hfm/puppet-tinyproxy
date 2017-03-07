class tinyproxy::config (
  Enum['file', 'absent'] $config_ensure,
  Integer $port,
  Optional[String] $listen,
  Optional[String] $bind,
  Optional[Boolean] $bind_same,
  Integer $timeout,
  Optional[Hash[Integer, String]] $error_files,
  String $default_error_file,
  Optional[String] $stat_host,
  String $stat_file,
  Optional[String] $log_file,
  Boolean $use_syslog,
  String $pid_file,
  Boolean $use_xtinyproxy,
  Optional[Array[String]] $default_upstreams,
  Optional[Hash[String, Variant[String, Array[String]]]] $upstreams,
  Optional[Array[String]] $no_upstreams,
  Integer $max_clients,
  Integer $min_spare_servers,
  Integer $max_spare_servers,
  Integer $start_servers,
  Integer $max_requests_per_child,
  Optional[String] $allow,
  Optional[String] $deny,
  Optional[Hash[String, String]] $add_headers,
  String $via_proxy_name,
  Boolean $disable_via_header,
  Enum['Critical', 'Error', 'Warning', 'Notice', 'Connect', 'Info'] $log_level,
  Optional[Array[String]] $anonymous,
  Optional[Array[Integer]] $connect_ports,
  Optional[Hash[String, String]] $reverse_paths,
){

  if $log_file != undef and $use_syslog == true {
    fail('$use_syslog and $log_logfile are mutually exclusive.')
  }

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
