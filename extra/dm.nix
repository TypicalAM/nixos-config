{ config, pkgs, ...}:

{
  # Window manager stuff
	environment.systemPackages = with pkgs; [ 
		libsForQt5.qt5.qtgraphicaleffects
		libsForQt5.qtstyleplugin-kvantum
		catppuccin-kvantum
		lxappearance
		qt5ct
	];

	qt = {
		enable = true;
		platformTheme = "qt5ct";
	};

  services.xserver = {
    enable = true;
    layout = "pl";
    xkbVariant = "";

		desktopManager.xterm.enable = false;
		displayManager = {
			sddm.enable = true;
			sddm.theme = "${(pkgs.fetchFromGitHub {
    		owner = "MarianArlt";
    		repo = "sddm-chili";
    		rev = "6516d50176c3b34df29003726ef9708813d06271";
    		sha256 = "wxWsdRGC59YzDcSopDRzxg8TfjjmA3LHrdWjepTuzgw=";
			})}";
			defaultSession = "none+i3";
		};

		windowManager.i3 = {
			package = pkgs.i3-gaps;
			enable = true;
		};
  };
}
