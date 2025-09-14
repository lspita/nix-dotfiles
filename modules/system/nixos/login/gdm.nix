{ config, lib, ... }:
lib.custom.mkModule {
  inherit config;
  path = [
    "nixos"
    "login"
    "gdm"
  ];
  mkConfig =
    { ... }:
    {
      services.displayManager.gdm = {
        enable = true;
        wayland = config.custom.modules.nixos.core.wayland.enable;
      };
    };
}
