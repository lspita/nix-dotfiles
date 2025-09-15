{
  config,
  lib,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "gnome"
    "nautilus"
  ];
  mkConfig =
    { ... }:
    {
      dconf.settings."org/gnome/nautilus/preferences" = {
        show-create-link = true;
        show-delete-permanently = true;
      };
    };
}
