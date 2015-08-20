#!/bin/bash

packages=(

nano
vim
rsync
wget
ntp
ntpdate
ntsysv
screen
setuptool
system-config-network-tui
yum-presto
yum-priorities

)

if [ ${#packages[@]} -eq 0 ]; then
    echo "No packages to install"
else
    yum install "${packages[@]}" -y
    yum update -y
fi
