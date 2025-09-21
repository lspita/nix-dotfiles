{
  config,
  lib,
  pkgs,
  systemType,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "security"
    "bitwarden"
  ];
  extraOptions = {
    sshAgent = {
      enable = lib.mkEnableOption "bitwarden ssh agent";
    };
  };
  mkConfig =
    { cfg }:
    let
      package = pkgs.bitwarden-desktop;
    in
    {
      home = {
        packages = [ package ];
        sessionVariables = lib.mkIf cfg.sshAgent.enable (
          let
            sockerDir =
              let
                homeDir = config.home.homeDirectory;
              in
              {
                linux = homeDir;
                darwin = "${homeDir}/Library/Containers/com.bitwarden.desktop/Data";
              };
          in
          {
            SSH_AUTH_SOCK = "${sockerDir.${systemType}}/.bitwarden-ssh-agent.sock";
          }
        );
      };
      xdg.autostart.entries = [ "${package}/share/applications/bitwarden.desktop" ];
    };
}
