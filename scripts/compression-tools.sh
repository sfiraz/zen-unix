#!/bin/bash
set -e

echo "Installing compression tools..."

cd toolchain

# Install zip/unzip
wget -q http://fl.us.mirror.archlinuxarm.org/aarch64/core/zip-3.0-10-aarch64.pkg.tar.xz
tar -xf zip-*.pkg.tar.xz
cp -r usr ../rootfs/rootfs.dir/

wget -q http://fl.us.mirror.archlinuxarm.org/aarch64/core/unzip-6.0-21-aarch64.pkg.tar.xz
tar -xf unzip-*.pkg.tar.xz
cp -r usr ../rootfs/rootfs.dir/

# Install xz
wget -q http://fl.us.mirror.archlinuxarm.org/aarch64/core/xz-5.6.3-1-aarch64.pkg.tar.xz
tar -xf xz-*.pkg.tar.xz
cp -r usr ../rootfs/rootfs.dir/

# Install bzip2
wget -q http://fl.us.mirror.archlinuxarm.org/aarch64/core/bzip2-1.0.8-6-aarch64.pkg.tar.xz
tar -xf bzip2-*.pkg.tar.xz
cp -r usr ../rootfs/rootfs.dir/

# Install gzip
wget -q http://fl.us.mirror.archlinuxarm.org/aarch64/core/gzip-1.13-1-aarch64.pkg.tar.xz
tar -xf gzip-*.pkg.tar.xz
cp -r usr ../rootfs/rootfs.dir/

# Install p7zip (7z format)
wget -q http://fl.us.mirror.archlinuxarm.org/aarch64/core/p7zip-17.05-1-aarch64.pkg.tar.xz
tar -xf p7zip-*.pkg.tar.xz
cp -r usr ../rootfs/rootfs.dir/

echo "Compression tools installed"
