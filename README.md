# ufw-openvz

A bash script to fix an issue with UFW and OpenVZ containers. The issue is caused by UFW not playing nice with iptables, sysctl, logging and ipv6. This script has been tested on an openVZ vps running Ubuntu 12.04 64bit.

All credit goes to...

1. [blog.bodhizazen.net](http://blog.bodhizazen.net/linux/how-to-use-ufw-in-openvz-templates)
2. [blog.kylemanna.com](http://blog.kylemanna.com/linux/2013/04/26/ufw-vps)
