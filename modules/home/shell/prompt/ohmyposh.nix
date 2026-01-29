{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./ohmyposh.nix {
  options = {
    theme = lib.mkOption {
      type = with lib.types; str;
      description = "oh my posh theme";
    };
  };
  config =
    { self, ... }:
    {
      home.packages = with pkgs; [ blesh ];
      programs.oh-my-posh = {
        enable = true;
        useTheme = self.theme;
      };
      custom.shell.rc = lib.mkAfter [ (shell: ''eval "$(oh-my-posh init ${shell})"'') ];
    };
}
