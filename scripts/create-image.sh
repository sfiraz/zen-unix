#!/bin/bash
set -e

echo "Creating disk image..."

mkdir -p output
cd output
rm -f zen-unix.img

# Buat empty image file 64MB
dd if=/dev/zero of=zen-unix.img bs=1M count=64

# Format sebagai ext4 filesystem
mkfs.ext4 zen-unix.img

# Mount image
mkdir -p mnt
sudo mount -o loop zen-unix.img mnt

# Copy rootfs ke image
sudo cp -r ../rootfs/rootfs.dir/* mnt/

# Unmount image
sudo umount mnt

# Cleanup
rm -rf mnt

echo "Disk image created: zen-unix.img"
