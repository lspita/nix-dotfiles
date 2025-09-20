{
  config,
  lib,
  ...
}:
lib.custom.mkDefaultsModule {
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
        direnv.enable = mkDefault true;
        environment.enable = mkDefault true;
        git.enable = mkDefault true;
        nix.enable = mkDefault true;
        nh.enable = mkDefault true;
      };
    };
}
