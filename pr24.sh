#!/usr/bin/env bash
set -e

echo "[*] Update package list..."
sudo apt-get update

echo "[*] Install base dependencies..."
sudo apt-get install -y \
  wget curl unzip git python3-pip \
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

# Install Node.js 22.x (tanpa reinstall npm global)
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Playwright (Node.js, local install)
npm init -y
npm install playwright

# Install Chromium for Playwright
npx playwright install chromium

echo "[*] Done! You can now run tests with Playwright."
