
---

### **6. scripts/download-sources.sh**
```bash
#!/bin/bash
set -e

echo " Downloading all sources for Zen Unix..."
mkdir -p sources
cd sources

# CORE COMPONENTS
echo " Downloading core components..."
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.6.9.tar.xz
wget https://musl.libc.org/releases/musl-1.2.4.tar.gz
wget https://busybox.net/downloads/busybox-1.36.1.tar.bz2
wget https://ftp.gnu.org/gnu/binutils/binutils-2.42.tar.xz

# DEVELOPMENT TOOLS
echo " Downloading development tools..."
wget https://go.dev/dl/go1.21.6.src.tar.gz
wget https://github.com/neovim/neovim/archive/refs/tags/v0.9.5.tar.gz -O neovim-v0.9.5.tar.gz
wget https://curl.se/download/curl-8.5.0.tar.xz

# ESSENTIAL UTILITIES
echo " Downloading utilities..."
wget https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz
wget https://github.com/htop-dev/htop/archive/refs/tags/3.2.2.tar.gz -O htop-3.2.2.tar.gz
wget https://astron.com/pub/file/file-5.45.tar.gz

echo " All sources downloaded successfully!"
ls -la *.tar.*
