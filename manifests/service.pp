class tinyproxy::service (
  Enum['running','stopped'] $service_ensure,
  Boolean                   $service_enable,
){

  service { 'tinyproxy':
    ensure => $service_ensure,
    enable => $service_enable,
  }

}
