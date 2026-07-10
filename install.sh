#!/bin/bash

# --- CONFIGURATION ---
# Run 'lsblk' first to identify your target disk (e.g., /dev/sda, /dev/vda)
TARGET_DISK="/dev/sda" 
# ---------------------

# 1. Download and Extract
wget -O chr.img.zip https://download.mikrotik.com/routeros/7.5/chr-7.5.img.zip
unzip -p chr.img.zip > chr.img

# 2. Prepare for mounting
modprobe loop
mkdir -p /mnt/chr
mount -o loop,offset=512 chr.img /mnt/chr

# 3. Inject Configuration
# Removed interface-specific lines, leaving only global settings
cat <<EOF > /mnt/chr/rw/autorun.scr
/ip service disable telnet
/user set 0 name=root password=xxxxxx
EOF

# 4. Cleanup
umount /mnt/chr
sync

# 5. Flash to Disk
echo "Writing image to $TARGET_DISK... This will wipe the disk."
dd if=chr.img of=$TARGET_DISK bs=4M conv=fsync

# 6. Finalize
sync
echo "Rebooting..."
echo b > /proc/sysrq-trigger
