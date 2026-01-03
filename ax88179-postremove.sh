#!/usr/bin/env bash

# Check if any other versions of this module are still registered in DKMS
# If this was the last one, clean up the global config
if [ $(dkms status ax_usb_nic | grep -c "installed") -eq 0 ]; then
    echo "DKMS: Last instance of ax_usb_nic removed. Cleaning up global configs..."
    # remove default drivers block
    rm -f /etc/modprobe.d/blacklist-asix.conf

    # remove kernel module from load at boot time
    sed -i '/^ax_usb_nic$/d' /etc/modules
fi

# $1 is the kernel version being built (passed by DKMS)
KVER=$1
echo "DKMS: Updating initramfs for kernel $KVER..."
update-initramfs -u -k "$KVER"