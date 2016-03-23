require 'fileutils'
require 'uri'
require 'puppet/util'

Puppet::Type.newtype(:torrent_file) do
  desc "Puppet type that downloads a file from a torrent-server"

  ensurable

  newparam(:name, :namevar => true) do
    desc "Remote file name"

    validate do |value|
      unless File.dirname(value) == '.'
        raise(ArgumentError, 'Name attribute may not include directories')
      end
    end
  end

  newparam(:path) do
    desc "Directory where the file should be created locally"

    validate do |value|
      unless Puppet::Util.absolute_path?(value)
        fail Puppet::Error, "File paths must be fully qualified, not '#{value}'"
      end
    end

    munge do |value|
      if value.start_with?('//') and ::File.basename(value) == "/"
        # This is a UNC path pointing to a share, so don't add a trailing slash
        ::File.expand_path(value)
      else
        ::File.join(::File.split(::File.expand_path(value)))
      end
    end
  end

  newparam(:server) do
    desc "URL of the torrent-server hosting the file"

    validate do |value|
      begin
        uri = URI.parse(value)
      rescue URI::InvalidURIError => detail
        raise(ArgumentError, "Could not understand URI #{value}: #{detail}")
      end
    end
  end

  newparam(:port) do
    desc "Port to use for the BitTorrent client"

    munge do |value|
      value.to_i
    end
  end

  autorequire(:file) do
    self[:path]
  end

  validate do
    unless self[:path] and self[:server]
      raise(Puppet::Error, 'Both path and server are required attributes')
    end

    self[:ensure] = :present unless self[:ensure]
  end
end
