#!/bin/bash
set -e

echo "Installing additional tools..."

cd toolchain

# Install Go dengan error handling
echo "Installing Go..."
if wget -q https://go.dev/dl/go1.25.4.linux-arm64.tar.gz; then
    tar -xf go1.25.4.linux-arm64.tar.gz
    cp -r go ../rootfs/rootfs.dir/usr/
else
    echo "Go download failed, skipping..."
fi

# Install GCC
echo "Installing GCC..."
if wget -q http://fl.us.mirror.archlinuxarm.org/aarch64/core/gcc-14.2.0-1-aarch64.pkg.tar.xz; then
    tar -xf gcc-*.pkg.tar.xz
    cp -r usr ../rootfs/rootfs.dir/
else
    echo "GCC download failed, skipping..."
fi

# Install Git
echo "Installing Git..."
if wget -q http://fl.us.mirror.archlinuxarm.org/aarch64/core/git-2.49.1-1-aarch64.pkg.tar.xz; then
    tar -xf git-*.pkg.tar.xz
    cp -r usr ../rootfs/rootfs.dir/
else
    echo "Git download failed, skipping..."
fi

# Install zlib
echo "Installing zlib..."
if wget -q http://fl.us.mirror.archlinuxarm.org/aarch64/core/zlib-1:1.3.1-2-aarch64.pkg.tar.xz; then
    tar -xf zlib-*.pkg.tar.xz
    cp -r usr ../rootfs/rootfs.dir/
else
    echo "zlib download failed, skipping..."
fi

# Install Neovim
echo "Installing Neovim..."
if wget -q https://github.com/neovim/neovim/releases/download/stable/nvim-linux-arm64.tar.gz; then
    tar -xf nvim-linux-arm64.tar.gz
    cp -r nvim-linux-arm64 ../rootfs/rootfs.dir/usr/
else
    echo "Neovim download failed, skipping..."
fi

# Cleanup
rm -rf *.tar.* *.pkg.* usr go 2>/dev/null || true

echo "Tools installation complete"
