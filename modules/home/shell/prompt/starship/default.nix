{
  config,
  lib,
  pkgs,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "shell"
    "prompt"
    "starship"
  ];
  mkConfig =
    { ... }:
    let
      preset = "jetpack";
    in
    {
      home.packages = with pkgs; [ blesh ];
      programs.starship = {
        enable = true;
        settings =
          if builtins.isNull preset then { } else builtins.fromTOML (builtins.readFile ./${preset}.toml);
      };
    };
}
