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
  extraOptions = {
    preset = lib.mkOption {
      type = with lib.types; nullOr str;
      default = null;
      description = "starship preset to use";
    };
  };
  mkConfig =
    { cfg }:
    {
      home.packages = with pkgs; [ blesh ];
      programs.starship = with cfg; {
        enable = true;
        settings =
          if builtins.isNull preset then
            { }
          else
            builtins.fromTOML (builtins.readFile ./presets/${preset}.toml);
      };
    };
}
