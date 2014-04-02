#!/bin/bash

disk=$1
img=$2

if [[ $(id -u) != "0" ]]; then
    echo "Must run as root because of direct blockdevice writing."
    echo "Rerun with: sudo $0 $*"
    exit 2
fi

if [[ ! -n $disk ]]; then
    echo "Usage: $0 <USB disk identifier> <img from mkdmg.sh>"
    echo "Current disk layout:"
    diskutil list
    exit 1
fi

if [[ ! -f "$img" ]]; then
    echo "Please create a compatible image from your ISO by running mkdmg.sh"
    exit 1
fi

diskutil unmountDisk /dev/$disk
#diskutil partitionDisk /dev/$disk 1 "Free Space" "unused" "100%"

hasPv=`command -v pv`

echo "Writing disk image $img to $disk..."
if hash pv 2> /dev/null; then
    pv -preb "$img" | dd of=/dev/r$disk bs=1m
else
    echo "If you had 'pv' installed, you'd see progress output here."
    dd if="$img" of=/dev/r$disk bs=1m
fi

if [[ $? == 0 ]]; then
    diskutil eject /dev/$disk
    echo "Disk ejected; ready for use."
else
    echo "Image not written.  Not ejecting disk so you can try again."
fi

