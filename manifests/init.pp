# Class: torrent_client
# ===========================
#
# Installs the torrent_client Ruby gem as a pre-req
#
class torrent_client (
  $provider = 'puppet_gem'
) {
  package {'torrent_client':
    ensure   => '0.1.0',
    provider => $provider,
  }
}
