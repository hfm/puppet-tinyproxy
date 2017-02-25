class tinyproxy::service (
  Enum['running','stopped'] $service_ensure,
  Boolean                   $service_enable,
){

  service { 'tinyproxy':
    ensure => $service_enable,
    enable => $service_enable,
  }

}
