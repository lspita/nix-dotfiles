{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./cosmic-greeter.nix {
  config = {
    services.displayManager.cosmic-greeter.enable = true;
  };
}
