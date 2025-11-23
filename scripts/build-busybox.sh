#!/bin/bash
set -e

echo "Building BusyBox for ARM64..."

cd toolchain

wget -q https://busybox.net/downloads/busybox-1.36.1.tar.bz2
tar -xf busybox-1.36.1.tar.bz2
cd busybox-1.36.1

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig

sed -i 's/.*CONFIG_STATIC.*/CONFIG_STATIC=y/' .config

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- install

echo "BusyBox build complete"
