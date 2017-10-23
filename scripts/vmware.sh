#!/bin/bash

apt-get -y -qq update
apt-get -y -qq install build-essential
apt-get -y -qq install linux-headers-$(uname -r)
apt-get -y -qq install open-vm-tools
