{
  config,
  customLib,
  pkgs,
  lib,
  ...
}:
customLib.mkModule {
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
              with pkgs.stdenv;
              let
                homeDir = config.home.homeDirectory;
              in
              if isLinux then
                homeDir
              else if isDarwin then
                "${homeDir}/Library/Containers/com.bitwarden.desktop/Data"
              else
                throw "Unsupported platform for bitwarden ssh agent socket";
          in
          {
            SSH_AUTH_SOCK = "${sockerDir}/.bitwarden-ssh-agent.sock";
          }
        );
      };
      xdg.autostart.entries = [ "${package}/share/applications/bitwarden.desktop" ];
    };
}
