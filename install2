#!/bin/bash

# Configuration
DISK="/dev/vda"
IMAGE_URL="https://github.com/tikoci/fat-chr/releases/download/7.23.2/chr-7.23.2.img.zip"

# Install requirements
apt update && apt install -y unzip

# Download and Extract
wget -O chr.img.zip $IMAGE_URL
unzip chr.img.zip
# Finds the extracted image (usually chr-*.img)
IMG_FILE=$(ls chr-*.img)

# Flash the image
echo "Writing $IMG_FILE to $DISK..."
dd if=$IMG_FILE of=$DISK bs=4M conv=fsync status=progress

# Ensure writes are flushed
sync
echo "Done. Please exit Rescue Mode and boot from your hard drive."
