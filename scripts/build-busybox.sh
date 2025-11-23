#!/bin/bash
set -e

echo "Building BusyBox for ARM64..."

cd toolchain

wget -q https://busybox.net/downloads/busybox-1.36.1.tar.bz2
tar -xf busybox-1.36.1.tar.bz2
cd busybox-1.36.1

# Gunakan oldconfig untuk non-interactive build
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig

# Set config secara non-interactive
sed -i 's/.*CONFIG_STATIC.*/CONFIG_STATIC=y/' .config
sed -i 's/.*CONFIG_FEATURE_USE_INITTAB.*/CONFIG_FEATURE_USE_INITTAB=n/' .config

# Apply changes tanpa prompt interaktif
yes "" | make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- oldconfig

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- install

echo "BusyBox build complete"
