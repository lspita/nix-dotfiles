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
    "linux"
    "desktop"
    "gnome"
  ];
  mkConfig =
    { ... }:
    {
      custom.modules.linux.desktop.gnome = with lib; {
        settings.enable = mkDefault true;
      };
    };
}
