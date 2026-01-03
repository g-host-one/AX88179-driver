#!/usr/bin/env bash

# remove default drivers block
rm -f /etc/modprobe.d/blacklist-asix.conf

# remove kernel module from load at boot time
sed -i '/^ax_usb_nic$/d' /etc/modules

# $1 is the kernel version being built (passed by DKMS)
KVER=$1
echo "DKMS: Updating initramfs for kernel $KVER..."
update-initramfs -u -k "$KVER"