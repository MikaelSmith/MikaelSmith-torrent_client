# Class: torrent_client
# ===========================
#
# Full description of class torrent_client here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class torrent_client (
  $package_name = $::torrent_client::params::package_name,
  $service_name = $::torrent_client::params::service_name,
) inherits ::torrent_client::params {

  # validate parameters here

  class { '::torrent_client::install': } ->
  class { '::torrent_client::config': } ~>
  class { '::torrent_client::service': } ->
  Class['::torrent_client']
}
