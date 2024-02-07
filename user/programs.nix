{ config, lib, pkgs, ... }:

{
  programs = {
    nm-applet.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall =
        true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall =
        true; # Open ports in the firewall for Source Dedicated Server
    };
  };

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
    whatsapp-for-linux
    telegram-desktop
    webcord
    obs-studio

    # Gaming
    dwarfs
    fuse-overlayfs
    nix-index
    wineWowPackages.staging
    looking-glass-client
  ];
}
