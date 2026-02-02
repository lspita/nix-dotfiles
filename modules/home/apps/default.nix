{ lib, hostInfo, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    let
      notWsl = !hostInfo.wsl;
    in
    setDefaultSubconfig {
      vscode.enable = notWsl;
      zed = {
        enable = true;
        package.enable = notWsl;
      };
      obsidian.enable = notWsl;
      libreoffice.enable = notWsl;
      bitwarden = {
        enable = notWsl;
        autostart.enable = true;
        sshAgent.enable = true;
      };
      firefox = {
        enable = notWsl;
        passwordManager.enable = false; # use bitwarden instead
      };
      spotify.enable = notWsl;
    };
}
