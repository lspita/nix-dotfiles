{
  config,
  lib,
  pkgs,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "terminal"
    "gnome-console"
  ];
  mkConfig =
    { ... }:
    {
      home.packages = with pkgs; [ gnome-console ];
      dconf.settings."org/gnome/Console" = {
        theme = "auto";
        font-scale = 1.1;
      };
    };
}
