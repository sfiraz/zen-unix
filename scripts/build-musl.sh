#!/bin/bash
set -e

echo "Building MUSL libc for ARM64..."

mkdir -p toolchain
cd toolchain

wget -q https://musl.libc.org/releases/musl-1.2.4.tar.gz
tar -xf musl-1.2.4.tar.gz
cd musl-1.2.4

./configure \
    --target=aarch64-linux-gnu \
    --prefix=/usr/aarch64-linux-musl

make -j$(nproc)
sudo make install

echo "MUSL build complete"
