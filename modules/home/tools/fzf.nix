{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./fzf.nix {
  config = {
    programs.fzf.enable = true;
  };
}
