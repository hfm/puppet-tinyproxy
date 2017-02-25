class tinyproxy::install (
  Boolean $use_epel,
  String  $package_ensure,
){

  case $facts['os']['family'] {
    'RedHat': {
      if $use_epel {
        require ::epel
      }
    }
    'Debian': {
      include ::apt
      require ::apt::update
    }
    default: {
      fail("Module ${module_name} is not supported on ${facts['os']['family']}")
    }
  }

  package { 'tinyproxy':
    ensure => $package_ensure,
  }

}
