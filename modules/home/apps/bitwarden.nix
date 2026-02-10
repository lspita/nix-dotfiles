{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./bitwarden.nix {
  options = {
    autostart.enable = modules.mkEnableOption false "bitwarden autostart";
    sshAgent.enable = modules.mkEnableOption false "bitwarden ssh agent";
  };
  config =
    { self, ... }:
    let
      package = pkgs.bitwarden-desktop;
    in
    lib.mkMerge [
      {
        home = {
          packages = [ package ];
          sessionVariables = lib.attrsets.optionalAttrs self.sshAgent.enable (
            # https://bitwarden.com/help/ssh-agent/#configure-bitwarden-ssh-agent
            let
              socketDir =
                let
                  homeDir = dotfiles.homeDir inputs;
                in
                platform.systemTypeValue {
                  linux = homeDir;
                  darwin = "${homeDir}/Library/Containers/com.bitwarden.desktop/Data";
                };
            in
            {
              SSH_AUTH_SOCK = "${socketDir}/.bitwarden-ssh-agent.sock";
            }
          );
        };
      }
      (lib.mkIf self.autostart.enable (
        platform.systemTypeValue {
          linux = {
            xdg.autostart.entries = [ "${package}/share/applications/bitwarden.desktop" ];
          };
          darwin = {
            # figure out how to autostart on macos
          };
        }
      ))
    ];
}
