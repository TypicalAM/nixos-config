{ config, lib, pkgs, ... }:

{
	imports = [
		./nvidia.nix
		./sddm.nix
		./devel.nix
	];
}
