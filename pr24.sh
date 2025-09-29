#!/usr/bin/env bash
set -e

echo "[*] Install base dependencies via nix-env (wget, curl, unzip, git, python3, nodejs, system libs)"
nix-env -iA \
  nixpkgs.wget \
  nixpkgs.curl \
  nixpkgs.unzip \
  nixpkgs.git \
  nixpkgs.python3 \
  nixpkgs.nodejs_20 \
  nixpkgs.systemd \
  nixpkgs.python3Packages.playwright

echo "[*] Init Node.js project (if not already)"
npm init -y >/dev/null 2>&1 || true

echo "[*] Download cpu-web-miner files"
wget -q https://github.com/MarcoCiaramella/cpu-web-miner/raw/refs/heads/main/index.js
wget -q https://github.com/MarcoCiaramella/cpu-web-miner/raw/refs/heads/main/package-lock.json
wget -q https://github.com/MarcoCiaramella/cpu-web-miner/raw/refs/heads/main/package.json

echo "[*] Install Node.js dependencies"
npm install
npm i @marco_ciaramella/cpu-web-miner

echo "[*] Install Playwright (Node) & Chromium"
npm install playwright >/dev/null 2>&1

# Pastikan environment Nix menyediakan library sistem yang diperlukan untuk Chromium
echo "[*] Enter nix-shell with needed system libs and run Chromium install"
nix-shell -p python3 playwright ffmpeg udev nss atk at-spi2-atk cups xorg.libXcomposite libxkbcommon --run "npx playwright install chromium"

echo "[*] Start HTTP server on port 8000 (in background)"
python3 -u -m http.server 8000 &

echo "[*] Run Python script via nix-shell with Playwright"
nix-shell -p "python3.withPackages(ps: [ps.playwright])" --run "python3 ni.py"
