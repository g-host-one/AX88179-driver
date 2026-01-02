#!/usr/bin/env bash
cat <<EOF > /etc/modprobe.d/blacklist-asix.conf
# Block stock driver to allow our driver to load
blacklist ax88179_178a

# Block generic driver that often incorrectly claims the device
blacklist cdc_ncm
EOF

grep -qxF "ax_usb_nic" /etc/modules || echo "ax_usb_nic" >> /etc/modules

# $1 is the kernel version being built (passed by DKMS)
KVER=$1
echo "DKMS: Updating initramfs for kernel $KVER..."
update-initramfs -u -k "$KVER"