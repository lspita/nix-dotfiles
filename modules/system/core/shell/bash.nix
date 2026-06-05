{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./bash.nix {
  config = {
    programs.bash.enable = true;
  };
}
