{
  config,
  lib,
  pkgs,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "packages"
  ];
  mkConfig =
    { ... }:
    {
      home.packages = with pkgs; [
        nixd
        nil
        lua-language-server
        git
        spotify
      ];
    };
}
