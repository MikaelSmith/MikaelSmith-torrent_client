# == Class torrent_client::params
#
# This class is meant to be called from torrent_client.
# It sets variables according to platform.
#
class torrent_client::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'torrent_client'
      $service_name = 'torrent_client'
    }
    'RedHat', 'Amazon': {
      $package_name = 'torrent_client'
      $service_name = 'torrent_client'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
