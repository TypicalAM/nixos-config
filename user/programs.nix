{ config, lib, pkgs, ... }:

{
  programs = { nm-applet.enable = true; };

  environment.systemPackages = with pkgs; [
    # Theming
    starship
    bibata-cursors
    pfetch
    pywal
    picom
    dunst
    rofi
    polybar

    # Shell-related
    neovim
    ranger
    ripgrep
    pass
    unzip
    file
    which
    tree
    gawk
    zstd
    gnupg
    exa
    bat
    glow

    # Programming & blogging
    gh
    cargo
    nixfmt
    hugo

    # System administration
    lsof
    ethtool
    pciutils
    usbutils
    nix-output-monitor

    # Random
    telegram-desktop
    discord
    obs-studio

    # Gaming
    dwarfs
    fuse-overlayfs
    nix-index
    wineWowPackages.staging
    looking-glass-client
  ];
}
