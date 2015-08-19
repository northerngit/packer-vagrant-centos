#!/bin/bash

# Install the VMWare Tools from a linux ISO.
yum install -y fuse-libs

mount -o loop /tmp/linux.iso /media/

cd /tmp
tar xzf /media/VMwareTools-*.tar.gz

umount /media/
rm -fr /tmp/linux.iso

/tmp/vmware-tools-distrib/vmware-install.pl -d
rm -fr /tmp/vmware-tools-distrib

# Fix HGFS kernel module timeout - https://dantehranian.wordpress.com/2014/08/19/vagrant-vmware-resolving-waiting-for-hgfs-kernel-module-timeouts/
sed -i 's/answer AUTO_KMODS_ENABLED_ANSWER no/answer AUTO_KMODS_ENABLED_ANSWER yes/g' /etc/vmware-tools/locations
sed -i 's/answer AUTO_KMODS_ENABLED no/answer AUTO_KMODS_ENABLED yes/g' /etc/vmware-tools/locations
