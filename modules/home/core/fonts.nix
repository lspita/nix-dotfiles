{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "core"
    "fonts"
  ];
  mkConfig =
    { ... }:
    {
      home.packages = vars.fonts.packages pkgs;
      fonts.fontconfig.enable = true;
    };
}
