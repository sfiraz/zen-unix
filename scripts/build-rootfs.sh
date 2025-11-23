#!/bin/bash
set -e

echo "Building RootFS..."

mkdir -p rootfs
cd rootfs
rm -rf rootfs.dir
mkdir -p rootfs.dir

cd rootfs.dir
mkdir -p bin dev etc proc sys tmp usr/bin usr/sbin usr/lib var/log

cp -r ../../toolchain/busybox-1.36.1/_install/* .

cat > init << 'EOF'
#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev

echo "Welcome to Zen Unix!"
exec /bin/sh
EOF

chmod +x init

echo "RootFS structure created"
