#!/bin/bash

# Provision vagrant user
groupadd vagrant
useradd vagrant -g vagrant -G wheel
echo "vagrant" | passwd --stdin vagrant

# Store build time
date > /etc/vagrant_box_build_time

# Allow sudo access for vagrant user
echo 'vagrant ALL=NOPASSWD:ALL' > /etc/sudoers.d/vagrant
echo '%wheel ALL=NOPASSWD: ALL' >> /etc/sudoers.d/vagrant
echo 'Defaults env_keep="SSH_AUTH_SOCK"' >> /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant

# Install vagrant SSH key
echo 'Install vagrant SSH key'
mkdir -pm 700 /home/vagrant/.ssh
curl -kL https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub > /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh
