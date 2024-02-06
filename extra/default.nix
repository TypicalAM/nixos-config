{ config, lib, pkgs, ... }:

{
  imports = [ ./nvidia.nix ./dm.nix ./devel.nix ./virtualization.nix ];
}
