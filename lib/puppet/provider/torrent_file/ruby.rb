# Provider for torrent_file using quartz_torrent

require 'puppet/file_system'
require 'puppet/util/execution'
require 'net/http'
require 'tempfile'
require 'cgi'
require 'uri'

Puppet::Type.type(:torrent_file).provide(:ruby) do
    confine :feature => :torrent_client

  def filename
    File.join(resource[:path], resource[:name])
  end

  def torrent_path
    return @torrent_path if @torrent_path

    uri = URI("#{resource[:server]}/#{CGI.escape(resource[:name])}")
    metastring = Net::HTTP.get(uri)
    torrent_file = Tempfile.new("#{resource[:name]}.torrent")
    torrent_file.write metastring
    torrent_file.close

    @torrent_path = torrent_file.path
  end

  def exists?
    TorrentClient.verify torrent_path, resource[:path]
  end

  def create
    TorrentClient.download torrent_path, resource[:path]
  end

  def destroy
    Puppet::FileSystem.unlink filename
  end
end
