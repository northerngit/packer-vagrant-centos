#!/bin/bash

# Remove persistent interface rules to ensure unique MAC Addresses
rm -f /etc/udev/rules.d/70-persistent-net.rules
rm -f /var/lib/dhclient/dhclient-eth0.leases

for ifcfg in /etc/sysconfig/network-scripts/ifcfg-*
do
    if [ "$(basename "${ifcfg}")" != "ifcfg-lo" ]
    then
        sed -i '/^UUID/d'   /etc/sysconfig/network-scripts/ifcfg-eth0
        sed -i '/^HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-eth0
    fi
done
