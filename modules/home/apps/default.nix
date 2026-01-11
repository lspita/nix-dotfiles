{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig {
      editors = {
        vscode.enable = true;
        zed.enable = true;
        obsidian.enable = true;
      };
      security.bitwarden = {
        enable = true;
        sshAgent.enable = true;
      };
      browsers.firefox = {
        enable = true;
        passwordManager.enable = false; # use bitwarden instead
      };
      media.spotify.enable = true;
    };
}
