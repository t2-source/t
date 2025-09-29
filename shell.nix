{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    # Tools dasar
    pkgs.wget
    pkgs.curl
    pkgs.unzip
    pkgs.git

    # Node.js + npm
    pkgs.nodejs_20

    # Python + pip + playwright
    pkgs.python311Full
    pkgs.python311Packages.pip
    pkgs.python311Packages.playwright

    # Library runtime Chromium / Playwright
    pkgs.gtk3
    pkgs.libxkbcommon
    pkgs.nss
    pkgs.mesa
    pkgs.pango
    pkgs.at-spi2-core
    pkgs.cups
    pkgs.alsa-lib

    # X11 libs (pakai namespace xorg.*)
    pkgs.xorg.libxshmfence
    pkgs.xorg.libXcomposite
    pkgs.xorg.libXrandr
    pkgs.xorg.libXdamage
    pkgs.xorg.libXext
    pkgs.xorg.libXfixes
  ];

  shellHook = ''
    echo "[*] Environment siap! Jalankan ./script kamu"
  '';
}
