{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig {
      coding = {
        vscode.enable = true;
        zed.enable = true;
      };
      security.bitwarden = {
        enable = true;
        sshAgent.enable = true;
      };
      browser.firefox = {
        enable = true;
        passwordManager.enable = false;
      };
      music.spotify.enable = true;
      notes.obsidian.enable = true;
    };
}
