{ pkgs, lib, ... }:

{
  networking.hostName = "placeholderX";
  time.timeZone = "Europe/Warsaw";

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
  ];

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.adam = {
      isNormalUser = true;
      description = "Adam";
      extraGroups = [ "docker" "wheel" ];
      initialPassword = "12345678";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN1mU7I3EFWpa9zyWOKJs6TRJATQkwPH/utv5/e26qcI Nix development VM"
      ];

      packages = with pkgs; [
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
      rebuild = "sudo nixos-rebuild switch --flake /home/adam/nixos-config#dev";
      vi = "nvim";
      ga = "git add .";
      gc = "git commit -m";
      gs = "git status";
      gd = "git diff | bat";
      s = "grep -i --color";
    };

    shellInit = ''
      ra() {
        local IFS=$'\t\n'
        local tempfile="$(mktemp -t tmp.XXXXXX)"
        local ranger_cmd=(
            command
            ranger
            --cmd="map q chain shell echo %d > "$tempfile"; quitall"
        )
        
        ''${ranger_cmd[@]} "$@"
        if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
            cd -- "$(cat "$tempfile")" || return
        fi
        command rm -f -- "$tempfile" 2>/dev/null
      }
    '';
  };

  fileSystems."/home/adam" = {
    fsType = "virtiofs";
    device = "hostshare";
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

  system.stateVersion = "25.05";
}
