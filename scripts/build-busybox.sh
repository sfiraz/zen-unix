#!/bin/bash
set -e

echo "Building BusyBox for ARM64..."

# Buat directory toolchain
mkdir -p toolchain
cd toolchain

# Download BusyBox
wget https://busybox.net/downloads/busybox-1.36.1.tar.bz2
tar -xf busybox-1.36.1.tar.bz2
cd busybox-1.36.1

# Config default untuk ARM64
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig

# Enable static build
sed -i 's/# CONFIG_STATIC is not set/CONFIG_STATIC=y/' .config

# Build
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)

echo "BusyBox build completed successfully"
