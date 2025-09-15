{
  config,
  lib,
  pkgs,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "gnome"
    "theme"
    "adw-gtk3"
  ];
  mkConfig =
    { ... }:
    {
      home.packages = with pkgs; [ adw-gtk3 ];
      dconf.settings."org/gnome/desktop/interface".gtk-theme = "adw-gtk3";
    };
}
