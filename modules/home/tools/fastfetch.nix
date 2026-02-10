{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./fastfetch.nix {
  options = {
    neofetchAlias = modules.mkEnableOption true "neofetch alias";
  };
  config =
    { self, ... }:
    {
      programs.fastfetch = {
        enable = true;
      };
      home.shellAliases = lib.attrsets.optionalAttrs self.neofetchAlias { neofetch = "fastfetch"; };
    };
}
