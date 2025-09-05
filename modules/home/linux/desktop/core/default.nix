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
    "core"
  ];
  mkConfig =
    { ... }:
    with lib;
    {
      custom.modules.linux.desktop.core = {
        xdg.enable = mkDefault true;
      };
    };
}
