{
  config,
  lib,
  pkgs,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "gh"
  ];
  mkConfig =
    { ... }:
    {
      programs.gh = {
        enable = true;
        extensions = with pkgs; [
          gh-notify
          gh-skyline
        ];
      };
    };
}
