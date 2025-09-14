{
  config,
  lib,
  pkgs,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "security"
    "protonpass"
  ];
  mkConfig =
    { ... }:
    {
      home = {
        packages = with pkgs; [
          proton-pass
        ];
      };
    };
}
