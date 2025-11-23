#!/bin/bash
set -e

echo "Building BusyBox for ARM64..."

mkdir -p toolchain
cd toolchain

wget https://busybox.net/downloads/busybox-1.36.1.tar.bz2
tar -xf busybox-1.36.1.tar.bz2
cd busybox-1.36.1

# Clean dan setup config
make distclean
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig

# Enable static build
sed -i 's/# CONFIG_STATIC is not set/CONFIG_STATIC=y/' .config

# DISABLE problematic features
sed -i 's/CONFIG_TC=y/# CONFIG_TC is not set/' .config  # Disable traffic control
sed -i 's/CONFIG_FEATURE_MOUNT_NFS=y/# CONFIG_FEATURE_MOUNT_NFS is not set/' .config
sed -i 's/CONFIG_UDHCPC=y/# CONFIG_UDHCPC is not set/' .config
sed -i 's/CONFIG_UDHCPD=y/# CONFIG_UDHCPD is not set/' .config

# Build
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)

echo "BusyBox build completed successfully"
