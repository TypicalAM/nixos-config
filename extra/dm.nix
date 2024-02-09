{ config, pkgs, ... }:

let
  sddm-chili = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-chili";
    rev = "6516d50176c3b34df29003726ef9708813d06271";
    sha256 = "wxWsdRGC59YzDcSopDRzxg8TfjjmA3LHrdWjepTuzgw=";
  };
in {
  # Window manager stuff
  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qtstyleplugin-kvantum
    lxappearance
    qt5ct
    hyprpaper
    waybar
    wl-clipboard
    grim
    slurp
  ];

  programs.dconf.enable = true;

  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  # Enabled services
  services = {
    dbus = {
      enable = true;
      implementation = "broker";
    };

    xserver = {
      enable = true;
      layout = "pl";
      xkbVariant = "";

      desktopManager.xterm.enable = false;
      displayManager = {
        defaultSession = "none+i3";

        sddm = {
          enable = true;
          theme = "${sddm-chili}";
        };
      };

      windowManager = {
        i3 = {
          package = pkgs.i3-gaps;
          enable = true;
        };

        hypr.enable = true;
      };
    };
  };
}
