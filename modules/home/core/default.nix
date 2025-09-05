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
    "core"
  ];
  mkConfig =
    { ... }:
    with lib;
    {
      custom.modules.core = {
        environment.enable = mkDefault true;
        git.enable = mkDefault true;
        nix.enable = mkDefault true;
        nh.enable = mkDefault true;
      };
    };
}
