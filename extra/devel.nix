{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [(
		python3.withPackages(ps: with ps; [
			pandas
			matplotlib
			requests
		])
	)];
}
