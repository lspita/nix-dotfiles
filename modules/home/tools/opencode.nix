{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./opencode.nix {
  config = {
    programs.opencode = {
      enable = true;
      settings = {
        theme = "system";
      };
    };
  };
}
