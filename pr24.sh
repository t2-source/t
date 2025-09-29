#!/usr/bin/env bash
set -e

echo "[*] Install base dependencies with nix-env..."

# install tools & bahasa
nix-env -iA nixpkgs.wget nixpkgs.curl nixpkgs.unzip nixpkgs.git nixpkgs.python3 nixpkgs.nodejs_20 nixpkgs.systemd nixpkgs.python3Packages.playwright
nix-shell -p "python3.withPackages(ps: [ps.playwright])"


echo "[*] Init Node.js project..."
npm init -y

echo "[*] Install Playwright..."
#pip3 install playwright

echo "[*] Install Chromium for Playwright..."
#npx playwright install chromium
python3 -m playwright install chromium


echo "[*] Done! You can now run tests with Playwright."
