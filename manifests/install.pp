# == Class torrent_client::install
#
# This class is called from torrent_client for install.
#
class torrent_client::install {

  package { $::torrent_client::package_name:
    ensure => present,
  }
}
