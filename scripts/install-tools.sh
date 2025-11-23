#!/bin/bash
set -e

echo "Installing additional tools..."

cd toolchain

# Download dan install Go
echo "Installing Go..."
wget -q https://go.dev/dl/go1.25.4.linux-arm64.tar.gz
tar -xf go1.25.4.linux-arm64.tar.gz
cp -r go ../rootfs/rootfs.dir/usr/

# Download dan install GCC (C/C++ compiler)
echo "Installing GCC..."
wget -q http://fl.us.mirror.archlinuxarm.org/aarch64/core/gcc-14.2.0-1-aarch64.pkg.tar.xz
tar -xf gcc-*.pkg.tar.xz
cp -r usr ../rootfs/rootfs.dir/

# Download dan install Git
echo "Installing Git..."
wget -q http://fl.us.mirror.archlinuxarm.org/aarch64/core/git-2.49.1-1-aarch64.pkg.tar.xz
tar -xf git-*.pkg.tar.xz
cp -r usr ../rootfs/rootfs.dir/

# Download dan install zlib
echo "Installing zlib..."
wget -q http://fl.us.mirror.archlinuxarm.org/aarch64/core/zlib-1:1.3.1-2-aarch64.pkg.tar.xz
tar -xf zlib-*.pkg.tar.xz
cp -r usr ../rootfs/rootfs.dir/

# Download dan install Neovim (editor)
echo "Installing Neovim..."
wget -q https://github.com/neovim/neovim/releases/download/stable/nvim-linux-arm64.tar.gz
tar -xf nvim-linux-arm64.tar.gz
cp -r nvim-linux-arm64 ../rootfs/rootfs.dir/usr/

# Cleanup
rm -rf *.tar.* *.pkg.* usr go

echo "Tools installation complete"
