{ config, pkgs, ... }:

{
	imports = [
		./zsh.nix
		./prompt.nix
	];
}
