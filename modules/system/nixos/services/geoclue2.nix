{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./geoclue2.nix {
  config = {
    services.geoclue2.enable = true;
  };
}
