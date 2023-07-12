{ config, pkgs, ... }:

let
	catppuccin-theme = pkgs.fetchFromGitHub {
			owner = "catppuccin";
			repo = "Kvantum";
			rev = "04be2ad3d28156cfb62478256f33b58ee27884e9";
			sha256 = "apOPiVwePXbdKM1/0HAfHzIqAZxvfgL5KHzhoIMXLqI=";
	};
in {
	home.packages = with pkgs; [
		tela-icon-theme
	];

	xdg = {
		configFile = {
			"Kvantum/Catpuccin-Mocha-Lavender/Catpuccin-Mocha-Lavender.kvconfig".source = "${catppuccin-theme}/src/Catppuccin-Mocha-Lavender/Catppuccin-Mocha-Lavender.kvconfig";
			"Kvantum/Catpuccin-Mocha-Lavender/Catpuccin-Mocha-Lavender.svg".source = "${catppuccin-theme}/src/Catppuccin-Mocha-Lavender/Catppuccin-Mocha-Lavender.svg";
      "Kvantum/kvantum.kvconfig".text = ''
				[General]
				theme=Catpuccin-Mocha-Lavender
			'';
			"qt5ct/qt5ct.conf".text = ''
				[Appearance]
				color_scheme_path=${pkgs.qt5ct}/colors/airy.conf
				custom_palette=false
				icon_theme=McMojave-circle-purple
				standard_dialogs=default
				style=kvantum
			'';
		};
	};

	gtk.iconTheme = {
		name = "Tela-Icon-Theme";
		package = pkgs.tela-icon-theme;
	};

	services.picom = {
		enable = true;
		fade = true;
		fadeExclude = [ "class_g = 'Rofi'" ];
		fadeDelta = 3;
		backend = "glx";
		opacityRules = [
			"88:class_g = 'Code'"
			"85:class_g = 'discord'"
			"85:class_g = 'Spotify'"
		];

		# More settings here that are not exposed in an option
		settings = {
			blur = {
  			method = "dual_kawase";
  			strength = 5;
  			background = false;
  			background-frame = false;
  			background-fixed = true;
			};

			blur-background-exclude = [
				"class_g = 'firefox'"
				"class_g = 'Polybar'"
				"class_g = 'slop'"
			];

			corner-radius = 10;
			rounded-corners-exclude = [
				"class_g = 'Polybar'"
			];
		};
	};
}
