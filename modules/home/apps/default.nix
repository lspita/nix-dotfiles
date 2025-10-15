{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultModules, ... }:
    setDefaultModules {
      editor.vscode.enable = true;
      security.bitwarden = {
        enable = true;
        sshAgent.enable = true;
      };
      browser.firefox = {
        enable = true;
        passwordManager.enable = false;
      };
      spotify.enable = true;
    };
}
