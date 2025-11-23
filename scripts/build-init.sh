#!/bin/bash
set -e

echo "Building Zen Shell system..."

# Build Zen Shell - path yang fix
echo "Compiling Zen Shell..."
aarch64-linux-gnu-gcc -static -Os -o rootfs/rootfs.dir/bin/zen zen.c

# Buat init script
cat > rootfs/rootfs.dir/init << 'EOF'
#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev
echo "Booting Zen Unix..."
exec /bin/zen
EOF

chmod +x rootfs/rootfs.dir/init

echo "Zen Shell system built"
