{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./ghostty.nix {
  options = {
    theme = lib.mkOption {
      type = with lib.types; either str attrs;
      default = {
        dark = "Catppuccin Mocha";
        light = "Catppuccin Latte";
      };
      description = "Ghostty theme";
    };
  };
  config =
    { self, ... }:
    {
      programs.ghostty = {
        enable = true;
        settings.theme =
          if builtins.isString self.theme then self.theme else with self.theme; "dark:${dark},light:${light}";
      };
    };
}
