{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./jq.nix {
  config = {
    programs.jq.enable = true;
  };
}
