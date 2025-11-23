#!/bin/bash
set -e

echo "Building RootFS..."

mkdir -p rootfs
cd rootfs
rm -rf rootfs.dir
mkdir -p rootfs.dir

cd rootfs.dir

# Buat directory structure
mkdir -p bin dev etc proc sys tmp usr/bin usr/sbin usr/lib

# Copy BusyBox binary
cp ../../toolchain/busybox-1.36.1/busybox bin/

# Buat init script
cat > init << 'EOF'
#!/bin/sh

# Mount filesystems
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev

echo "Welcome to Zen Unix!"

# Jalankan shell
exec /bin/busybox sh
EOF

# Set permissions
chmod +x init
chmod +x bin/busybox

echo "RootFS structure created successfully"
