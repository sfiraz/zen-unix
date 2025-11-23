#!/bin/bash
set -e

echo "Building Linux Kernel for ARM64..."

cd toolchain

wget -q https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.6.9.tar.xz
tar -xf linux-6.6.9.tar.xz
cd linux-6.6.9

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig

if [ -f ../../configs/kernel-config ]; then
    cp ../../configs/kernel-config .config
fi

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)

echo "Kernel build complete"
