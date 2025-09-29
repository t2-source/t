{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python311
    python311Packages.playwright

    # GLib stack
    glib
    gobject-introspection
    atk
    at-spi2-core
    at-spi2-atk
    gtk3
    pango
    cairo

    # X11
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
    xorg.libxshmfence

    # dbus + cups
    dbus
    cups

    # NSS / NSPR
    nss
    nspr

    # Graphics
    mesa
    mesa.libdrm

    # Audio
    alsa-lib

    # Other required
    expat
    ffmpeg
  ];

  shellHook = ''
    echo "[*] Environment Playwright Chromium siap!"
    if [ ! -d "$HOME/.cache/ms-playwright/chromium-"* ]; then
      echo "[*] Download Chromium Playwright..."
      playwright install chromium
    fi
    echo "[*] Menjalankan python3 nix.py ..."
    python3 nix.py
    exit
  '';
}
