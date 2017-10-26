#!/bin/bash

nmap -sP 192.168.128.0/24
cat /proc/net/arp | grep b8:27:eb:5a:28:a6
