
# ASIX AX88179 / AX88179A Linux Driver (DKMS Enabled)

This repository contains the **v3.5.0** vendor driver for the ASIX AX88179/AX88179A USB 3.0 Gigabit Ethernet adapter, updated with full DKMS support and system automation.

### 🚀 Key Improvements in this Repository:
* **DKMS Support:** Automatically recompiles the driver whenever you update your Linux kernel—no manual rebuilding required.
* **Smart Makefile:** Patched to support the `KVER` variable, ensuring the driver builds against the target kernel headers, not just the currently running one.
* **Automatic Blacklisting:** The `postinstall` script automatically blacklists the stock drivers (`ax88179_178a` and `cdc_ncm`) to prevent them from "stealing" the device.
* **Boot Persistence:** Automatically adds the module to `/etc/modules` so your network interface is available immediately upon boot.
* **Clean Uninstallation:** The `postremove` script intelligently cleans up system configs only if no other versions of this driver remain on the system.

---

### 🛠 Hardware Identification

This driver is specifically for the **ASIX Electronics Corp. AX88179** chipset (ID `0b95:1790`).

You likely need this driver if your `lsusb` matches:
`Bus 004 Device 002: ID 0b95:1790 ASIX Electronics Corp. AX88179 Gigabit Ethernet`

And your device is being incorrectly handled by the generic `cdc_ncm` driver:
```text
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
    |__ Port 1: Dev 2, If 0, Class=Communications, Driver=cdc_ncm, 5000M
    |__ Port 1: Dev 2, If 1, Class=CDC Data, Driver=cdc_ncm, 5000M
```

---
### 📦 Prerequisites
You must have the Linux kernel headers installed for your specific kernel version.

**For Debian / Ubuntu:**

```bash
sudo apt update
sudo apt install dkms build-essential linux-headers-$(uname -r)
```

---
### ⚙️ Installation

**1. Prepare the Source**

Clone the repository and move it to the system source directory. The folder name must match the format ax-usb-nic-3.5.0.

```bash
git clone https://github.com/g-host-one/AX88179-driver.git
sudo mv AX88179-driver /usr/src/ax-usb-nic-3.5.0
cd /usr/src/ax-usb-nic-3.5.0
```

**2. ⚠️ Set Permissions (Critical)**

The postinstall and postremove scripts handle the blacklisting and system configuration. DKMS will fail to execute these scripts if the execution bit is not set.

```bash
sudo chmod +x ax88179-postinstall.sh
sudo chmod +x ax88179-postremove.sh
```

**3. Register and Install with DKMS**

```bash
sudo dkms add ax-usb-nic/3.5.0
sudo dkms install ax-usb-nic/3.5.0
```

**4. 🔄 Reboot (Required)**

A reboot is required to ensure the conflicting drivers are fully unloaded and the system initializes the hardware using the new ax_usb_nic driver from the updated initramfs.

```bash
sudo reboot
```

---
### ✅ Verification

Check if the high-performance driver and version 3.5.0 are active:

```bash
ethtool -i <your_interface_name>
```

**Expected Result:**

* **driver:** ax_usb_nic

* **version:** 3.5.0

---
### 🗑 Uninstallation

Removing the module via DKMS will trigger the postremove.sh script to clean up the blacklist and boot entries.

```bash
sudo dkms remove ax-usb-nic/3.5.0 --all
```

---
### 🔗 Links
* **Official Product Page:** [AX88179A Info](https://www.asix.com.tw/en/product/USBEthernet/Super-Speed_USB_Ethernet/AX88179A)

* **Latest Vendor Source:** [v3.5.0 Download](https://www.asix.com.tw/en/support/download/file/1942)

---
## 📄 Original Vendor Readme

[Readme](Readme)