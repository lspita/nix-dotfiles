{
  customLib,
  config,
  lib,
  ...
}:
customLib.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "nixos"
    "core"
  ];
  mkConfig =
    { ... }:
    with lib;
    {
      custom.modules = {
        nix.enable = mkDefault true;
        nixos.core = {
          boot.enable = mkDefault true;
          filesystem.enable = mkDefault true;
          power.enable = mkDefault true;
          wayland.enable = mkDefault true;
          locale.enable = mkDefault true;
          services.enable = mkDefault true;
          user.enable = mkDefault true;
          bluetooth.enable = mkDefault true;
          audio = {
            pipewire.enable = mkDefault true;
          };
          network = {
            networkmanager.enable = mkDefault true;
          };
        };
      };
    };
}
