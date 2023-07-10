# NixOS Configuration

This is my current NixOS configuration, while im figuring the system out. NixOS is a Linux distribution built on the Nix package manager, which provides a declarative and reproducible approach to system configuration.

## Prerequisites

Before proceeding with the NixOS configuration, ensure that you have the following prerequisites:

- A basic understanding of Linux and system administration.
- Access to a NixOS installation or a virtual machine to test your configuration.
- Familiarity with the Nix package manager and its concepts.

## Building and Activating the Configuration

Once you have made changes to the NixOS configuration, follow these steps to build and activate it:

1. Ensure that you are in the directory containing your NixOS configuration files.
2. Build the configuration and once the build process completes successfully, activate it.

```
sudo nixos-rebuild switch
```

3. Now the new configuration will take effect.

## TODO

Things that I have yet to figure out:

- [ ] Dual GPU (AMD + NVIDIA)
- [ ] Kitty and zsh and aliases
- [ ] VFIO and GPU Passthrough
- [ ] Nextcloud-client not complaining
- [ ] Shared grub for all my systems

## Additional Resources

For more information and advanced configuration options, refer to the following resources:

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Nix Package Manager Manual](https://nixos.org/manual/nix/stable/)
- [NixOS Wiki](https://nixos.wiki/)

## Contributing

Contributions to this repository are welcome. If you find any issues or have suggestions for improvement, please submit a pull request.
