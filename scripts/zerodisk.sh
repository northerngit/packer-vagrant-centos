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

VolumeGroup=$(vgdisplay | grep Name | awk -F" " '{ print $3 }')

for j in $VolumeGroup
do
    echo "$j"
    lvcreate -l vgdisplay "$j" | grep Free | awk -F" " '{ print $5 }' -n zero "$j"
    if [ -a /dev/"$j"/zero ]; then
        cat /dev/zero > /dev/"$j"/zero
        /bin/sync
        sleep 10
        lvremove -f /dev/"$j"/zero
    fi
done

# Make sure we wait until all the data is written to disk, otherwise
# Packer might quit too early before the large files are deleted
sleep 10
sync
