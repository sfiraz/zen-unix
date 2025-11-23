#!/bin/bash
set -e

echo "Building simple init system..."

mkdir -p system
cd system

cat > simpleinit.c << 'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    printf("Zen Unix - Minimal Init System\n");
    system("mount -t proc none /proc");
    system("mount -t sysfs none /sys"); 
    system("mount -t devtmpfs none /dev");
    execl("/bin/sh", "sh", NULL);
    return 0;
}
EOF

aarch64-linux-gnu-gcc -static -o simpleinit simpleinit.c
cp simpleinit ../rootfs/rootfs.dir/init

echo "Init system built"
