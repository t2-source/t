{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    # Python + Playwright
    pkgs.python3
    pkgs.python3Packages.playwright
    pkgs.nodejs

    # Dependencies Chromium/Playwright
    pkgs.glib
    pkgs.gobject-introspection
    pkgs.nss
    pkgs.nspr
    pkgs.atk
    pkgs.at-spi2-atk
    pkgs.cups
    pkgs.gtk3
    pkgs.dbus
    pkgs.expat
    pkgs.libxcb
    pkgs.xorg.libxshmfence
    pkgs.xorg.libX11
    pkgs.xorg.libXcomposite
    pkgs.xorg.libXdamage
    pkgs.xorg.libXext
    pkgs.xorg.libXfixes
    pkgs.xorg.libXrandr
    pkgs.libxkbcommon
    pkgs.libdrm
    pkgs.libgbm
    pkgs.pango
    pkgs.cairo
    pkgs.alsaLib
  ];

  shellHook = ''
    echo "[*] Menyiapkan Playwright..."
    playwright install chromium || true

    echo "[*] Menjalankan python3 nix.py..."
    python3 nix.py
    sleep 999999999999999999999999
  '';
}
