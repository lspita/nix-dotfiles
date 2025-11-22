{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./bitwarden.nix {
  options = {
    sshAgent.enable = lib.mkEnableOption "bitwarden ssh agent";
  };
  config =
    { self, ... }:
    let
      package = pkgs.bitwarden-desktop;
    in
    {
      home = {
        packages = [ package ];
        sessionVariables =
          if self.sshAgent.enable then
            # https://bitwarden.com/help/ssh-agent/#tab-linux-6VN1DmoAVFvm7ZWD95curS
            let
              sockerDir =
                let
                  homeDir = dotfiles.homeDir inputs;
                in
                utils.systemValue {
                  linux = homeDir;
                  darwin = "${homeDir}/Library/Containers/com.bitwarden.desktop/Data";
                };
            in
            {
              SSH_AUTH_SOCK = "${sockerDir}/.bitwarden-ssh-agent.sock";
            }
          else
            { };
      };
      xdg.autostart.entries = [ "${package}/share/applications/bitwarden.desktop" ];
    };
}
