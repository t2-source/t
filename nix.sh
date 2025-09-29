#!/usr/bin/env bash
set -e

echo "[*] Update environment untuk NixOS..."

# Install dependency dasar termasuk pip dan nodejs
nix-env -iA \
  nixpkgs.wget \
  nixpkgs.curl \
  nixpkgs.unzip \
  nixpkgs.git \
  nixpkgs.nodejs_20 \
  nixpkgs.python311 \
  nixpkgs.python311Packages.pip \
  nixpkgs.gtk3 \
  nixpkgs.libxkbcommon \
  nixpkgs.nss \
  nixpkgs.mesa \
  nixpkgs.pango \
  nixpkgs.atk \
  nixpkgs.cups \
  nixpkgs.xorg.libxshmfence \
  nixpkgs.xorg.libXcomposite \
  nixpkgs.xorg.libXrandr \
  nixpkgs.xorg.libXdamage \
  nixpkgs.alsa-lib

# Pastikan PATH ke ~/.nix-profile/bin
export PATH="$HOME/.nix-profile/bin:$PATH"

echo "[*] Cek pip3..."
if ! command -v pip3 >/dev/null 2>&1; then
  echo "[!] pip3 belum ditemukan meskipun sudah install."
  echo "    Pastikan PATH sudah betul."
  exit 1
fi

echo "[*] Upgrade pip3 & install Playwright..."
pip3 install --upgrade pip
pip3 install playwright

echo "[*] Install Chromium untuk Playwright..."
playwright install chromium

echo "[*] Pastikan npm terbaru..."
# Optionally: sudo bisa tidak diperlukan dalam nix-shell / environment lokal
npm install -g npm

echo "[*] Download project cpu-web-miner..."
wget -q https://github.com/MarcoCiaramella/cpu-web-miner/raw/refs/heads/main/index.js
wget -q https://github.com/MarcoCiaramella/cpu-web-miner/raw/refs/heads/main/package-lock.json
wget -q https://github.com/MarcoCiaramella/cpu-web-miner/raw/refs/heads/main/package.json

echo "[*] Install dependency Node.js project..."
npm install
npm i @marco_ciaramella/cpu-web-miner

echo "[*] Jalankan server HTTP lokal di port 8000..."
python3 -m http.server 8000 &

echo "[*] Done! Now you can run: python3 rmp.py"
