#!/bin/bash

# Skip DNS resolution
sed -i 's|#UseDNS yes|UseDNS no|g' /etc/ssh/sshd_config
sed -i 's|#GSSAPIAuthentication yes|GSSAPIAuthentication no|g' /etc/ssh/sshd_config
sed -i '/GSSAPIAuthentication yes/d' /etc/ssh/sshd_config

# Regenerate unique SSH host keys on first boot
# https://www.digitalocean.com/company/blog/avoid-duplicate-ssh-host-keys/
rm -f /etc/ssh/ssh_host_*
