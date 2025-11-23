#!/bin/bash
set -e

echo "🔨 Building Linux Kernel for ARM64..."

# Download kernel
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.6.9.tar.xz
tar -xf linux-6.6.9.tar.xz
cd linux-6.6.9

# Basic ARM64 config
make ARCH=arm64 defconfig

# Custom config (kalo mau)
if [ -f ../configs/kernel-config ]; then
    cp ../configs/kernel-config .config
fi

# Build kernel
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)

echo "✅ Kernel build complete!"
