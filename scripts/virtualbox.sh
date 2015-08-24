#!/bin/bash

# Install the VirtualBox Guest Additions from an ISO.
yum -y install gcc make kernel-devel-`uname -r`

VBOX_VERSION=$(cat /tmp/.vbox_version)
cd /tmp
mount -o loop /tmp/VBoxGuestAdditions_$VBOX_VERSION.iso /media
sh /media/VBoxLinuxAdditions.run
umount /media
rm -rf /tmp/VBoxGuestAdditions_*.iso
