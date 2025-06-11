{
  description = "Adam's NixOS configuration";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; };

  outputs = inputs@{ nixpkgs, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ./extra ./user ];
      };

      dev = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./vm/configuration.nix
          ./vm/boot-config.nix
          "${nixpkgs}/nixos/modules/profiles/qemu-guest.nix"
        ];
      };
    };
  };
}
