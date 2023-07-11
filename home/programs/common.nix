{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
		# General
    neofetch
    neovim
		ranger

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep
		pass

    # networking tools
    nmap

    # misc
    file
    which
    tree
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    # system call monitoring
    lsof # list open files

    # system tools
    ethtool
    pciutils # lspci
    usbutils # lsusb

		discord
		telegram-desktop
    polybar
		obs-studio
	];

	services = {
		network-manager-applet.enable = true;
		redshift = {
			latitude = "52";
			longitude = "20";
			enable = true;
			tray = true;
		};

		nextcloud-client = {
			enable = true;
			startInBackground = true;
		};
	};

  programs = {
		bat.enable = true;
		exa.enable = true;
		jq.enable = true;
		ssh.enable = true;
		pywal.enable = true;

		git = {
			enable = true;
			userName = "TypicalAM";
			userEmail = "tpam_piaseczny@protonmail.com";
		};
	};
}
