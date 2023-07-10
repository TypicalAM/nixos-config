{ config, pkgs, ...}:

{
	# Configure the mouse size
	xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 96;
  };
}
