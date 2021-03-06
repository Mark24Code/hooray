# Hooray
[![Gem Version](https://badge.fury.io/rb/hooray.svg)](http://badge.fury.io/rb/hooray)
[![Coverage Status](https://coveralls.io/repos/nofxx/hooray/badge.svg?branch=master)](https://coveralls.io/r/nofxx/hooray?branch=master)
[![Code Climate](https://codeclimate.com/github/nofxx/hooray.svg)](https://codeclimate.com/github/nofxx/hooray)
[![Build Status](https://travis-ci.org/nofxx/hooray.svg?branch=master)](https://travis-ci.org/nofxx/hooray)



                         ,                                  ________
                        /|   |                              \      /
                         |___|  __   __   ,_    __,          \    /
                         |   |\/  \_/  \_/  |  /  |  |   |    \  /
                         |   |/\__/ \__/    |_/\_/|_/ \_/|/    \/
                                                        /|     ()
                                                        \|



Find devices around you. Fast and without hyphens.


## Install

    gem install hooray


## Use `hoo`


```
hoo list
```
```
NAME                        | IP         | MAC
----------------------------|------------|------------------
Motorola Mobility           | 10.1.1.70  | 34:bb:XX:XX:XX:XX
Giga-byte Technology Co.    | 10.1.1.71  | 94:de:XX:XX:XX:XX
Veih's Android              | 10.1.1.72  | 04:46:XX:XX:XX:XX
Nery's LG                   | 10.1.1.73  | cc:fa:XX:XX:XX:XX
nofxx's iPhone              | 10.1.1.77  | 64:a3:XX:XX:XX:XX
LG Electronics              | 10.1.1.79  | cc:fa:XX:XX:XX:XX
TP-Link                     | 10.1.1.253 | f8:d1:XX:XX:XX:XX
Siemens Subscriber Networks | 10.1.1.254 | 00:0b:XX:XX:XX:XX
---
8 nodes @ 2015-01-08 00:33:07 -0200 1.27s
```

**That's the idea: 1 second to find a device.**


## Find running services

```
hoo list web
```
```
NAME              | IP           | MAC
------------------|--------------|------------------
dsl modem         | 192.168.1.1  | 64:a3:XX:XX:XX:XX
test server       | 192.168.1.75 | 64:a3:XX:XX:XX:XX
nofxx desktop     | 192.168.1.77 | 64:a3:XX:XX:XX:XX
---
3 nodes @ 2014-12-11 19:23:11 -0200 1.10s
```

Or simply by ports:


```
hoo list 80
hoo list 6777 udp
hoo list 3000 4000 5000
```

## Monitor

```
hoo watch
```
```
New nodes @ 2014-12-11 13:53:06 -0200
NAME       | IP           | MAC
-----------|--------------|------------------
myphone    | 192.168.1.76 | 64:a3:XX:XX:XX:XX
```


## Use another program

```
hoo ssh myphone
```

Will execute: `ssh <ip of myphone>`

You can use any program, not just ssh.


## Use as a lib

```
require 'hooray'
Hooray::Seek.lan(port, protocol).nodes
Hooray::Seek.new(network, port, protocol).nodes
```

* Nil port means ICMP ping.
* Protocol always defaults to :tcp.
* Network defaults to LAN IP 24 bits masked.

Possible protocols: tcp, udp, http, wmi & icmp (requires root).


## Why?

Bind macs or fix IP's is also boring and a per device/node work.
As more we use connected (IoT) devices in our company, nmap gets boring.
Not to mention slow, there's no easy way to assign names to devices I know,
which makes OS scan/port scan a needed option most times (thus making it slower).
Also (please open a issue if you know how) even in fast mode nmap won't run in under 2s.
And, on recent updates, you need sudo for all of that.

## How?

```
hoo init
```

A ~/.horray folder is prepopulated:
devices.yml regex list you mac addresses with names you recognize.
services.yml regex list ports to names you recognize.


## Credits

* Ruby net-ping gem.
* Nmap`s mac precompiled prefixes.


Hooray should work on UNIX based systems.
Tested in Linux and OS X.
