{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jdk
    jetbrains.idea-ultimate
    gnumake
    act
    go
    gcc
    cargo
    nodejs
    gotestsum
    goreleaser
    pre-commit

    (python3.withPackages (ps: with ps; [ pip pandas matplotlib requests ]))
    (let base = pkgs.appimageTools.defaultFhsEnvArgs;
    in pkgs.buildFHSUserEnv (base // {
      name = "fhs";
      targetPkgs = pkgs:
        (
          # pkgs.buildFHSUserEnv provides only a minimal FHS environment,
          # lacking many basic packages needed by most software.
          # Therefore, we need to add them manually.
          #
          # pkgs.appimageTools provides basic packages required by most software.
          (base.targetPkgs pkgs) ++ [ pkgs.pkg-config pkgs.ncurses ]);
      profile = "export FHS=1";
      runScript = "bash";
      extraOutputsToInstall = [ "dev" ];
    }))
  ];
}
