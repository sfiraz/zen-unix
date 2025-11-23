#!/bin/bash
set -e

echo "Creating disk image..."

mkdir -p output
cd output
rm -f zen-unix.img

# Naikkan size jadi 256MB
dd if=/dev/zero of=zen-unix.img bs=1M count=64
mkfs.ext4 zen-unix.img

mkdir -p mnt
sudo mount -o loop zen-unix.img mnt
sudo cp -r ../rootfs/rootfs.dir/* mnt/
sudo umount mnt
rm -rf mnt

echo "Disk image created: zen-unix.img"
