{ config, lib, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [ glxinfo	];
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
		opengl = {
			enable = true;
			driSupport = true;
			driSupport32Bit = true;
		};

		nvidia = {
			modesetting.enable = true; # Modesetting is needed for most wayland compositors
			open = true; # Use the open source version of the kernel module (515.43.04+)
			nvidiaSettings = true; # Enable the nvidia settings menu
			package = config.boot.kernelPackages.nvidiaPackages.stable; # Optionally, you may need to select the appropriate driver version
		};
	};
}
