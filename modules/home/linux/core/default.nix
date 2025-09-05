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
    "core"
  ];
  mkConfig =
    { ... }:
    with lib;
    {
      custom.modules.linux.core = {
        xdg.enable = mkDefault true;
      };
    };
}
