{
  config,
  customLib,
  lib,
  ...
}:
customLib.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "linux"
    "desktop"
    "plasma"
  ];
  mkConfig =
    { ... }:
    with lib;
    {
      custom.modules.linux.desktop.plasma = {
        settings.enable = mkDefault true;
        appearance = {
          catppuccin.enable = mkDefault true;
          wallpapers.enable = mkDefault true;
        };
      };
    };
}
