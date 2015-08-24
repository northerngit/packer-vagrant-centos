#!/bin/bash

# Install the VirtualBox Guest Additions from an ISO.
yum -y install gcc make kernel-devel-`uname -r`

KERN_DIR=/usr/src/kernels/`uname -r`
export KERN_DIR

VBOX_VERSION=$(cat /tmp/.vbox_version)
cd /tmp
mount -o loop /tmp/VBoxGuestAdditions_$VBOX_VERSION.iso /media
sh /media/VBoxLinuxAdditions.run
umount /media
rm -rf /tmp/VBoxGuestAdditions_*.iso
