{
  config,
  lib,
  pkgs,
  ...
}:
lib.custom.mkProgramModule {
  inherit config;
  path = [
    "spotify"
  ];
  packages = pkgs.spotify;
}
