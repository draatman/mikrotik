# 1. Update the package list
sudo apt update

# 2. Install unzip
sudo apt install -y unzip

# 3. Download the Fat-CHR UEFI image
wget -O chr.img.zip https://github.com/tikoci/fat-chr/releases/download/7.23.2/chr-7.23.2.img.zip

# 4. Extract
unzip chr.img.zip
IMG_FILE=$(ls chr-*.img)

# 5. Flash the image (CRITICAL: Ensure this points to your disk /dev/vda)
echo "Writing image to /dev/vda..."
sudo dd if=$IMG_FILE of=/dev/vda bs=4M conv=fsync status=progress

# 6. Final sync
sync
echo "Flashing complete!"
