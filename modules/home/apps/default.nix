{ systemType, lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    let
      notWsl = systemType != "wsl";
    in
    setDefaultSubconfig {
      editors = {
        vscode.enable = notWsl;
        zed.enable = true;
        obsidian.enable = notWsl;
      };
      security.bitwarden = {
        enable = notWsl;
        sshAgent.enable = true;
      };
      browsers.firefox = {
        enable = notWsl;
        passwordManager.enable = false; # use bitwarden instead
      };
      media.spotify.enable = notWsl;
    };
}
