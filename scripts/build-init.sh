#!/bin/bash
set -e

echo "Building Zen Shell system..."

# Buat folder system jika belum ada
mkdir -p system
cd system

# Build Zen Shell
echo "Compiling Zen Shell..."
aarch64-linux-gnu-gcc -static -Os -o zen ../../zen.c

# Copy Zen Shell ke rootfs
cp zen ../rootfs/rootfs.dir/bin/

# Buat init script yang jalankan Zen Shell
cat > ../rootfs/rootfs.dir/init << 'EOF'
#!/bin/sh

# Mount filesystems
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev

echo "Booting Zen Unix..."

# Jalankan Zen Shell sebagai main shell
exec /bin/zen
EOF

chmod +x ../rootfs/rootfs.dir/init

echo "Zen Shell system built"
