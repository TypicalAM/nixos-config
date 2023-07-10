{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
    go
		gcc
		cargo

		(python3.withPackages(ps: with ps; [
			pandas
			matplotlib
			requests
		]))
	];
}
