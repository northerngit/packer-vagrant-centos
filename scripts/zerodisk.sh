#!/bin/bash

# Zero out free space using dd, then delete the written file.

FileSystem=$(grep ext /etc/mtab| awk -F" " '{ print $2 }')

for i in $FileSystem
do
    echo "Filling \"$i\" to 98%..."
    number=$(df -B 512 "$i" | awk -F" " '{print $4}' | grep -v Avail)
    dd count="$(awk -v t1="$number" 'BEGIN{printf "%.0f\n", (t1)* 98 / 100}')" if=/dev/zero of="$i"/EMPTY
    /bin/sync
    sleep 10
    echo "Removing \"$i\" temporary file(s)..."
    rm -f "$i"/EMPTY
done

# Zero out swap partition using dd, then delete the written file.
swappart=`cat /proc/swaps | tail -n1 | awk -F ' ' '{print $1}'`
swapoff $swappart;
dd if=/dev/zero of=$swappart bs=1M > /dev/null 2>&1;
mkswap $swappart > /dev/null 2>&1;
swapon $swappart;

# Make sure we wait until all the data is written to disk, otherwise
# Packer might quit too early before the large files are deleted
sleep 10
sync
