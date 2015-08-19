#!/bin/bash

# Remove old kernel updates
yum install yum-utils -y
package-cleanup --oldkernels --count=1

# Clear yum cache
yum clean all

# Remove bash history
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/vagrant/.bash_history

# Cleanup log files
find /var/log -type f | while read f; do echo -ne '' > $f; done;
