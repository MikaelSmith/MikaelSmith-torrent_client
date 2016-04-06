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

This module uses [libtorrent](http://www.libtorrent.org/) BitTorrent library written in C++ to download files served from a [torrent-server](https://github.com/MikaelSmith/torrent-server). Using BitTorrent to transfer files can result in faster transfers with less load on the file server.

The module includes two classes:
- `torrent_client` to configure the system for downloading files using BitTorrent
- `torrent_file` to download individual files

## Setup

### Beginning with torrent_client

Install [libtorrent](http://www.libtorrent.org/) and [boost](https://www.boost.org/) as pre-requisites for building the [torrent_client](https://github.com/MikaelSmith/torrent_client) Ruby gem.

On Mac OS X, that can be done via Homebrew
```
brew install boost libtorrent-rasterbar
```

## Usage

```
class {'::torrent_client':
  provider => 'puppet_gem',
}

Torrent_File {
  server => 'http://filehost:8000/torrent',
  port   => 5555,
}

torrent_file {'large file':
  path => '/tmp',
}
```

## Reference

### Classes

#### torrent_client

Install client prereqs; currently only [torrent_client](https://github.com/MikaelSmith/torrent_client).

- provider: select which package provider to use to install Ruby gems. Defaults to `puppet_gem`.

### Resources

#### torrent_file

Downloads a file.

- file: namevar, name of the file as stored on the server
- ensure: ensure the file is present/absent
- path: (required) fully qualified file path for a directory to download the file to
- server: (required) torrent server name and port
- port: port to use for the BitTorrent, defaults to 5555
