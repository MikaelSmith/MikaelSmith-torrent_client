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
    # TODO: download file
    uri = URI("#{resource[:server]}/#{CGI.escape(resource[:name])}")
    metastring = Net::HTTP.get(uri)
    torrent_file = Tempfile.new("#{resource[:name]}.torrent")
    torrent_file.write metastring
    torrent_file.close

    pwd = Dir.pwd
    begin
      Dir.chdir resource[:path]
      Puppet::Util::Execution.execute(['torrent_client', torrent_file.path])
    ensure
      Dir.chdir pwd
    end
  end

  def destroy
    Puppet::FileSystem.unlink filename
  end
end
