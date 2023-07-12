{ config, pkgs, ... }:

{
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
