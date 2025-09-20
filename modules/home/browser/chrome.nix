{
  config,
  lib,
  pkgs,
  ...
}:
lib.custom.mkProgramModule {
  inherit config;
  path = [
    "browser"
    "chrome"
  ];
  packages = pkgs.google-chrome;
}
