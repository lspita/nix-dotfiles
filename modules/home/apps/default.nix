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
      browser.firefox = {
        enable = true;
        passwordManager.enable = false;
      };
      media.spotify.enable = true;
    };
}
