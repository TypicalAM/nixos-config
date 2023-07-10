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
    polybar
		obs-studio
	];

	programs = {
		bat.enable = true;
		exa.enable = true;
		jq.enable = true;
		ssh.enable = true;
	};

	services = {
		network-manager-applet.enable = true;
		redshift = {
			latitude = "52.00N";
			longitude = "20.00E";
			enable = true;
			tray = true;
		};
	};


	programs.pywal.enable = true;

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "TypicalAM";
    userEmail = "tpam_piaseczny@protonmail.com";
  };


  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;

			aws.symbol = "  ";
			conda.symbol = " ";
			dart.symbol = " ";
			directory.read_only = " ";
			docker_context.symbol = " ";
			elixir.symbol = " ";
			elm.symbol = " ";
			git_branch.symbol = " ";
			golang.symbol = " ";
			hg_branch.symbol = " ";
			java.symbol = " ";
			julia.symbol = " ";
			lua.symbol = " ";
			memory_usage.symbol = " ";
			nim.symbol = " ";
			nodejs.symbol = " ";
			package.symbol = " ";
			python.symbol = " ";
			rlang.symbol = "ﳒ ";
			ruby.symbol = " ";
			rust.symbol = " ";
			scala.symbol = " ";
    };
  };

  # kitty - a cross-platform, GPU-accelerated terminal emulator
  #programs.kitty = {
  #  enable = true;
  #  # custom settings
  #};

	programs.zsh = {
    enable = true;
    autocd = true;
		oh-my-zsh = {
			enable = true;
			plugins = [ "zsh-autosuggestions/zsh-autosuggestions" ];
			theme = "cloud";
		};
	};

	services.nextcloud-client = {
		enable = true;
		startInBackground = true;
	};
}
