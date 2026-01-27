{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    let
      notWsl = !vars.linux.wsl;
    in
    setDefaultSubconfig {
      editors = {
        vscode.enable = notWsl;
        zed = {
          enable = true;
          package.enable = notWsl;
        };
        obsidian.enable = notWsl;
      };
      security.bitwarden = {
        enable = notWsl;
        autostart.enable = true;
        sshAgent.enable = true;
      };
      browsers.firefox = {
        enable = notWsl;
        passwordManager.enable = false; # use bitwarden instead
      };
      media.spotify.enable = notWsl;
    };
}
