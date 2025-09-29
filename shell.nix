{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python311
    python311Packages.playwright

    # Core GLib / GTK stack
    glib
    gobject-introspection
    atk
    at-spi2-core
    at-spi2-atk
    gtk3
    pango
    cairo

    # X11 libraries
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
    xorg.libxshmfence

    # DBus + Cups
    dbus
    cups

    # NSS / NSPR (security libs)
    nss
    nspr

    # Graphics / GBM
    mesa
    mesa.libgbm

    # Audio
    alsa-lib

    # Expat
    expat
  ];

  shellHook = ''
    echo "[*] Environment Playwright Chromium siap!"
    # Install Chromium browser otomatis kalau belum ada
    if [ ! -d "$HOME/.cache/ms-playwright/chromium-"* ]; then
      echo "[*] Download Chromium Playwright..."
      playwright install chromium
    fi

    echo "[*] Menjalankan python3 nix.py ..."
    python3 nix.py
    exit
  '';
}
