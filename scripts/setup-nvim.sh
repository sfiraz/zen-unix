#!/bin/bash
set -e

echo "Setting up Neovim configuration..."

cd rootfs/rootfs.dir

# Buat config directory
mkdir -p root/.config/nvim

# Basic init.lua untuk Neovim
cat > root/.config/nvim/init.lua << 'EOF'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Basic keymaps
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')

print("Zen Unix Neovim Ready!")
EOF

# Symlink nvim ke bin
ln -sf ../usr/nvim-linux-arm64/bin/nvim bin/nvim

echo "Neovim setup complete"
