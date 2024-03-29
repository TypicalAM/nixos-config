let
  gpuIDs = [
    "10de:2191" # NVIDIA Corporation TU116M [GeForce GTX 1660 Ti Mobile]
    "10de:1aeb" # NVIDIA Corporation TU116 High Definition Audio Controller
  ];
in { config, lib, pkgs, ... }:

{
  # Enable docker
  virtualisation.docker.enable = true;

  # Enable correct groups for user adam
  users.users.adam.extraGroups = [ "docker" ];

  # Enable flatpak
  services.flatpak.enable = true;

  specialisation = {
    gpu-passthrough.configuration = {

      # Virt-manager and looking glass
      environment.systemPackages = with pkgs; [
        virt-manager
        looking-glass-client
      ];

      system.nixos.tags = [ "gpu-passthrough" ];

      systemd.tmpfiles.rules = [
        "f /dev/shm/looking-glass 0660 adam kvm -"
        "f /dev/shm/my-little-shared-memory 0660 adam kvm -"
      ];

      virtualisation = {
        spiceUSBRedirection.enable = true;

        libvirtd = {
          enable = true;
          qemu.ovmf.packages =
            [ pkgs.OVMFFull.fd ]; # Include OVMF_CODE.secboot.fd
        };
      };

      # Enable correct groups for user adam
      users.users.adam.extraGroups = [ "libvirtd" "kvm" ];

      # Set the correct modules and boot params
      boot = {
        initrd.kernelModules = [
          "vfio_pci"
          "vfio"
          "vfio_iommu_type1"
          "vfio_virqfd"

          "nvidia"
          "nvidia_modeset"
          "nvidia_uvm"
          "nvidia_drm"
        ];

        kernelParams = [
          "amd_iommu=on"
          ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs)
        ];
      };
    };
  };
}
