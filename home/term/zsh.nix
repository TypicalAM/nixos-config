{ config, pkgs, ... }:

{
	programs.zsh = {
		enableAutosuggestions = true;
		enable = true;
		autocd = true;

		history = {
			size = 50000;
			save = 50000;
		};

		oh-my-zsh = {
			enable = true;
			theme = "cloud";
		};
	};
}
