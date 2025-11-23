#!/bin/bash
set -e

echo "Installing Android development tools..."

cd toolchain

# Install Java (OpenJDK)
echo "Installing Java..."
wget -q https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.13%2B8/OpenJDK17U-jdk_aarch64_linux_hotspot_17.0.13_8.tar.gz
tar -xf OpenJDK17U-jdk_aarch64_linux_hotspot_*.tar.gz
cp -r jdk-17.0.13+8 ../rootfs/rootfs.dir/usr/java

# Install Android SDK tools (command line only)
echo "Installing Android SDK..."
wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
mkdir -p android-sdk
unzip -q commandlinetools-linux-*.zip -d android-sdk
cp -r android-sdk ../rootfs/rootfs.dir/usr/

# Install Node.js (untuk Cordova)
echo "Installing Node.js..."
wget -q https://nodejs.org/dist/v20.18.0/node-v20.18.0-linux-arm64.tar.xz
tar -xf node-v20.18.0-linux-arm64.tar.xz
cp -r node-v20.18.0-linux-arm64 ../rootfs/rootfs.dir/usr/nodejs

echo "Android development tools installed"
