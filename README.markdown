#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with torrent_client](#setup)
    * [What torrent_client affects](#what-torrent_client-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with torrent_client](#beginning-with-torrent_client)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview


A client for downloading files via the BitTorrent protocol from a [torrent-server](https://github.com/MikaelSmith/torrent-server).

## Module Description

This module uses [QuartzTorrent](https://rubygems.org/gems/quartz_torrent) BitTorrent library written in Ruby to download files served from a [torrent-server](https://github.com/MikaelSmith/torrent-server). Using BitTorrent to transfer files can result in faster transfers with less load on the file server.

The module includes two classes:
- `torrent_client` to configure the system for downloading files using BitTorrent
- `torrent_file` to download individual files

## Setup

### What torrent_client affects

Setup will install the [QuartzTorrent](https://rubygems.org/gems/quartz_torrent) gem in the Ruby environment used to run Puppet.

### Beginning with torrent_client

## Usage

```
include '::torrent_client'

Torrent_File {
  server => 'http://filehost:6969',
}

torrent_file {'large file':
  path => '/tmp',
}
```

## Reference

### Classes

- `torrent_client`: install the [QuartzTorrent](https://rubygems.org/gems/quartz_torrent) gem

### Resources

#### torrent_file

Downloads a file.

- file: namevar, name of the file as stored on the server
- path: fully qualified file path for a directory to download the file to.
- ensure: ensure the file is present/absent.
- server: torrent server name and port
