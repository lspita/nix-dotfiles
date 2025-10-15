{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./ssh.nix {
  config = {
    services.openssh.enable = true;
  };
}
