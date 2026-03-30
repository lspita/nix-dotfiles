{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./avahi.nix {
  config = {
    services.avahi = {
      enable = true;
      # https://wiki.nixos.org/wiki/Printing
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
