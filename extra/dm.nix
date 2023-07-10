{ config, pkgs, ...}:

{
  # Window manager stuff
  services.xserver = {
    enable = true;
    layout = "pl";
    xkbVariant = "";

		desktopManager.xterm.enable = false;
		displayManager = {
			sddm.enable = true;
			sddm.theme = "kde-plasma-chili";
			defaultSession = "none+i3";
		};

		windowManager.i3 = {
			package = pkgs.i3-gaps;
			enable = true;
		};
  };
}
