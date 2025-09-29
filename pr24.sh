#!/usr/bin/env bash
set -e

echo "[*] Install base dependencies with nix-env..."

# install tools & bahasa
nix-env -iA nixpkgs.wget nixpkgs.curl nixpkgs.unzip nixpkgs.git nixpkgs.python3 nixpkgs.nodejs_20 nixpkgs.systemd

echo "[*] Init Node.js project..."
npm init -y

echo "[*] Install Playwright..."
pip3 install playwright

echo "[*] Install Chromium for Playwright..."
npx playwright install chromium

echo "[*] Done! You can now run tests with Playwright."
