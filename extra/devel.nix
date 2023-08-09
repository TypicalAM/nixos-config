{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
    go
		gcc
		cargo
		nodejs
		gotestsum
		pre-commit

		(
			python3.withPackages(ps: with ps; [
				pip
				pandas
				matplotlib
				requests
			])
		)
	];
}
