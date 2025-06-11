{ pkgs, ... }:

{
  time.timeZone = "Europe/Warsaw";
  networking = {
    hostName = "zajac18";
    firewall.enable = false;
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.trusted-users = [ "root" "adam" ];
  };

  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    docker-compose
    git
    wget
    curl
    rsync
    tmux
    python311
    gh
    ripgrep
    nil
    lua-language-server
    nixpkgs-fmt
    stow
    ranger
    neovim
    git-crypt
    hadolint
    oh-my-posh
    fzf
    fastfetch
    gum
    netcat
    bat
    go
    neofetch
    zsh
    eza
    btop
    go
    tmux
    xclip
    xsel
  ];

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      X11Forwarding = true;
      X11DisplayOffset = 10;
      X11UseLocalhost = true;
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.adam = {
      isNormalUser = true;
      description = "Adam";
      extraGroups = [ "docker" "wheel" "users" ];
      initialPassword = "12345678";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN1mU7I3EFWpa9zyWOKJs6TRJATQkwPH/utv5/e26qcI Nix development VM"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEsbsgABdG3HSaN3e2Tp0r/XnUIibHAGAXKbKSiEAdHY Nix development VM Small"
      ];
    };
  };

  programs.zsh = {
    enable = true;
    histSize = 50000;
    autosuggestions.enable = true;

    shellAliases = {
      lx = "eza -alhG --group-directories-first";
      "cd." = "cd ../";
      "cd.." = "cd ../../";
      cpp = "rsync -r --info=progress2 ";
      rf = "rm -r -f";
      rebuild = "sudo nixos-rebuild switch --flake /mnt/share/nixos-config#dev";
      vi = "nvim";
      ga = "git add .";
      gc = "git commit -m";
      gs = "git status";
      gd = "git diff | bat";
      s = "grep -i --color";
    };
  };

  fileSystems."/mnt/share" = {
    fsType = "virtiofs";
    device = "hostshare";
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  networking = {
    useDHCP = false;
    defaultGateway = "2.1.3.1";
    nameservers = [ "1.1.1.1" "8.8.8.8" ];

    interfaces.enp1s0.ipv4.addresses = [{
      address = "2.1.3.7";
      prefixLength = 24;
    }];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/home";
    fsType = "ext4";
    options = [ "defaults" ];
  };

  systemd.tmpfiles.rules =
    [ "d /home 0775 root root -" "d /home/adam 0700 adam users -" ];

  system.stateVersion = "25.05";
}
