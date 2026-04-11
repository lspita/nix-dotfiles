{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./iwd.nix {
  options = {
    enableNMWifiBackend = modules.mkEnableOption false "iwd as the network manager wifi backend";
  };
  config =
    { self, ... }:
    # https://wiki.nixos.org/wiki/Iwd
    {
      networking = {
        wireless.iwd.enable = true;
      } // (lib.attrsets.optionalAttrs self.enableNMWifiBackend {
        networkmanager.wifi.backend = "iwd";
      });
    };
}
