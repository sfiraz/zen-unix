#!/bin/bash
set -e

echo "Building RootFS..."

mkdir -p rootfs
cd rootfs
rm -rf rootfs.dir
mkdir -p rootfs.dir

cd rootfs.dir
mkdir -p bin dev etc proc sys tmp usr/bin usr/sbin usr/lib usr/share usr/java usr/android-sdk usr/nodejs home/user root

# Copy BusyBox binary
cp ../../toolchain/busybox-1.36.1/busybox bin/

echo "RootFS structure created"
