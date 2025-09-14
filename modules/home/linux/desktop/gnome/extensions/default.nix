{
  config,
  lib,
  ...
}:
lib.custom.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "linux"
    "desktop"
    "gnome"
    "extensions"
  ];
  mkConfig =
    { ... }:
    {
      dconf.settings."org/gnome/shell".disabled-extensions = [ ];
      custom.modules.linux.desktop.gnome.extensions = with lib; {
        dash-to-dock.enable = mkDefault true;
        blur-my-shell.enable = mkDefault true;
      };
    };
}
