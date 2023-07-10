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
	nix.settings.experimental-features = [ "nix-command" "flakes"];
	nix.settings.auto-optimise-store = true;
	nix.gc = {
			automatic = true;
			dates = "weekly";
			options = "--delete-older-than 1w";
	};

	# Bootloader
  boot.loader = {
  	efi = {
   		canTouchEfiVariables = true;
   	};
    grub = {
       enable = true;
       efiSupport = true;
       device = "nodev";
    };
  };

	# Define your hostname.
  networking.hostName = "nixos"; 

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.adam = {
    isNormalUser = true;
    description = "Adam Piaseczny";
    extraGroups = [ "networkmanager" "video" "wheel" "audio" "libvirt" "kvm"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
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
		lxappearance
		qt5ct
		virt-manager
  ];

	# Font things
	fonts.fonts = with pkgs; [
		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
		material-design-icons
		noto-fonts
	];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

	hardware.pulseaudio.enable = true;
	hardware.pulseaudio.support32Bit = true;
	programs.light.enable = true;
	programs.zsh.enable = true;
	users.users.adam.shell = pkgs.zsh;

  # List services that you want to enable:
	services = {
		picom.enable = true;
		dbus.enable = true;
	};
  
  virtualisation.libvirtd.enable = true; 
  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

	security.polkit.enable = true;
  environment.pathsToLink = [ "/libexec" ];

  # Window manager stuff
  services.xserver = {
    enable = true;
    layout = "pl";
    xkbVariant = "";

		desktopManager.xterm.enable = false;
		displayManager = {
			sddm.enable = true;
			sddm.theme = "kde-plasma-chili";
			defaultSession = "none+i3";
		};

		windowManager.i3 = {
			package = pkgs.i3-gaps;
			enable = true;
		};
  };

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
