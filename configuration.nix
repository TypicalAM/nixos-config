# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

	# Enable flakes
	nix = {
		settings = {
			experimental-features = [ "nix-command" "flakes"];
			auto-optimise-store = true;
		};
		gc = {
			automatic = true;
			dates = "weekly";
			options = "--delete-older-than 1w";
		};
	};

	# Bootloader
  boot = {
		kernelParams = [ "quiet" "splash" ];

		loader = {
			efi.canTouchEfiVariables = true;
			grub = {
				enable = true;
				efiSupport = true;
				device = "nodev";
				configurationLimit = 10;

				theme = pkgs.stdenv.mkDerivation {
					pname = "distro-grub-themes";
					version = "1.2";
					src = pkgs.fetchFromGitHub {
						owner = "Lxtharia";
						repo = "minegrub-theme";
						rev = "75764c248b9c523fb32c7387bed9aa34ba06a535";
						sha256 = "n/fJSFrrPPyTBS8/XHaARyCxccRZiqPhhNFq0x8Q2kA=";
					};
					installPhase = "cp -r . $out";
				};
    	};
		};
  };

	# Define your hostname.
  networking = {
		hostName = "nixos"; 
		networkmanager.enable = true;
	};

 	# Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "pl2";

	# Enable docker
	virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.adam = {
    isNormalUser = true;
    description = "Adam Piaseczny";
		shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "video" "wheel" "audio" "docker"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
		act
		youtube-dl
		spotify
		spicetify-cli

		# Essencials
		kitty
    git
    vim
    wget
		curl

		# Others
		polkit_gnome
		pass
    firefox
    rofi
    feh
    maim
    xclip
		nextcloud-client
    (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
      pkgs.buildFHSUserEnv (base // {
      name = "fhs";
      targetPkgs = pkgs: (
        # pkgs.buildFHSUserEnv provides only a minimal FHS environment,
        # lacking many basic packages needed by most software.
        # Therefore, we need to add them manually.
        #
        # pkgs.appimageTools provides basic packages required by most software.
        (base.targetPkgs pkgs) ++ [
          pkgs.pkg-config
          pkgs.ncurses
        ]
      );
      profile = "export FHS=1";
      runScript = "bash";
      extraOutputsToInstall = ["dev"];
    }))
  ];

	# Font things
	fonts.fonts = with pkgs; [
		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
		material-design-icons
		noto-fonts
	];

	# For nextcloud
 	services.gnome.gnome-keyring.enable = true;

	services.pipewire = {
		audio.enable = true;
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
		wireplumber.enable = true;
  };

	programs = {
		light.enable = true;
		zsh.enable = true;
		nix-ld.enable = true;
	};

  # List services that you want to enable:
	services = {
		dbus.enable = true;
	};
  
  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

	security.polkit.enable = true;
  environment.pathsToLink = [ "/libexec" ];

	systemd = {
		user.services.polkit-gnome-authentication-agent-1 = {
			description = "polkit-gnome-authentication-agent-1";
			wantedBy = [ "graphical-session.target" ];
			wants = [ "graphical-session.target" ];
			after = [ "graphical-session.target" ];
			serviceConfig = {
					Type = "simple";
					ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
					Restart = "on-failure";
					RestartSec = 1;
					TimeoutStopSec = 10;
				};
		};
		 extraConfig = ''
			 DefaultTimeoutStopSec=10s
		 '';
	}; 

	security.sudo.extraRules = [{
		groups = ["wheel"];
		commands = [{
			command = "/run/current-system/sw/bin/nixos-rebuild";
			options = [ "NOPASSWD" ];
		}];
	}];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
