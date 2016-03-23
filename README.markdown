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
- `torrent_client` to configure the system for downloading files using BitTorrent (not currently working)
- `torrent_file` to download individual files

## Setup

### Beginning with torrent_client

Install [libtorrent](http://www.libtorrent.org/), then compile an upcoming torrent_client based on the [simple_client example](https://github.com/MikaelSmith/libtorrent/blob/improve-simple-client/examples/simple_client.cpp).

## Usage

```
include '::torrent_client'

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

- `torrent_client`: install client prereqs

### Resources

#### torrent_file

Downloads a file.

- file: namevar, name of the file as stored on the server
- ensure: ensure the file is present/absent
- path: (required) fully qualified file path for a directory to download the file to
- server: (required) torrent server name and port
- port: port to use for the BitTorrent, defaults to 5555
