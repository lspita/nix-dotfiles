{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./fingerprint.nix {
  config = {
    services.fprintd.enable = true;
  };
}
