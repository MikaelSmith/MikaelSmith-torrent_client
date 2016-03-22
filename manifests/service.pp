# == Class torrent_client::service
#
# This class is meant to be called from torrent_client.
# It ensure the service is running.
#
class torrent_client::service {

  service { $::torrent_client::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
