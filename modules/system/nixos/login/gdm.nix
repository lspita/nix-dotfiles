{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./gdm.nix {
  options = {
    wayland = utils.mkTrueEnableOption "wayland support";
  };
  config =
    { self, ... }:
    {
      services.displayManager.gdm = {
        inherit (self) wayland;
        enable = true;
      };
    };
}
