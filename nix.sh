#!/usr/bin/env bash
set -e

echo "[*] Update environment untuk NixOS..."

# Install dependency dasar
nix-env -iA nixpkgs.wget nixpkgs.curl nixpkgs.unzip nixpkgs.git \
  nixpkgs.nodejs_20 nixpkgs.python311Full nixpkgs.python311Packages.pip \
  nixpkgs.gtk3 nixpkgs.libxkbcommon nixpkgs.nss nixpkgs.mesa \
  nixpkgs.pango nixpkgs.atk nixpkgs.cups nixpkgs.xorg.libxshmfence \
  nixpkgs.xorg.libXcomposite nixpkgs.xorg.libXrandr nixpkgs.xorg.libXdamage \
  nixpkgs.alsa-lib

# Upgrade pip & install Playwright
pip install --upgrade pip
pip install playwright

# Install Chromium untuk Playwright
playwright install chromium

# Pastikan npm terbaru
sudo npm install -g npm

# Download project cpu-web-miner
wget -q https://github.com/MarcoCiaramella/cpu-web-miner/raw/refs/heads/main/index.js
wget -q https://github.com/MarcoCiaramella/cpu-web-miner/raw/refs/heads/main/package-lock.json
wget -q https://github.com/MarcoCiaramella/cpu-web-miner/raw/refs/heads/main/package.json

# Install dependency Node.js project
npm install
npm i @marco_ciaramella/cpu-web-miner

# Jalankan server HTTP lokal di port 8000
python3 -m http.server 8000 &
echo "[*] Done! Now you can run: python3 rmp.py"
