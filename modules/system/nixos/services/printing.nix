{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./printing.nix {
  options = {
    drivers = lib.mkOption {
      type = with lib.types; listOf package;
      default = with pkgs; [
        cups-filters
        cups-browsed
      ];
      description = "List of printer drivers to install";
    };
  };
  config =
    { self, ... }:
    {
      # https://wiki.nixos.org/wiki/Printing
      services = {
        printing = {
          inherit (self) drivers;
          enable = true;
        };
        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
      };
    };
}
