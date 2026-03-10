{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./krunner.nix {
  options = {
    shortcuts.launch = plasma.mkShortcutOption { } "launch KRunner";
  };
  config =
    { self, ... }:
    {
      programs.plasma = {
        krunner = {
          position = "center";
          shortcuts.launch = self.shortcuts.launch;
        };
        configFile.krunnerrc = {
          Plugins.krunner_webshortcutsEnabled = false;
          General.FeedbackDisabled = true; # disable crash report
        };
      };
    };
}
