# Provider for torrent_file using quartz_torrent

require 'puppet/file_system'
require 'puppet/util/execution'
require 'net/http'
require 'tempfile'
require 'cgi'
require 'uri'

Puppet::Type.type(:torrent_file).provide(:ruby) do

  def filename
    File.join(resource[:path], resource[:name])
  end

  def exists?
    Puppet::FileSystem.exist? filename
  end

  def insync?(is)
    # TODO: implement content consistency check via torrent
    super
  end

  def create
    require 'torrent_client'

    uri = URI("#{resource[:server]}/#{CGI.escape(resource[:name])}")
    metastring = Net::HTTP.get(uri)
    torrent_file = Tempfile.new("#{resource[:name]}.torrent")
    torrent_file.write metastring
    torrent_file.close

    TorrentClient.download torrent_file.path, resource[:path]
  end

  def destroy
    Puppet::FileSystem.unlink filename
  end
end
