{
  config,
  customLib,
  pkgs,
  lib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "gnome"
    "settings"
  ];
  mkConfig =
    { ... }:
    {
      home.packages = with pkgs; [ dconf-editor ];
      dconf.settings = {
        "org/gnome/desktop/interface".gtk-enable-primary-paste = false;
        "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,maximize,close";
        "org/gnome/mutter".center-new-windows = true;
        "org/gnome/settings-daemon/plugins/color" = {
          # manual night light
          night-light-schedule-from = 0.0;
          night-light-schedule-to = 0.0;
          night-light-temperature = lib.hm.gvariant.mkUint32 3200;
        };
      };
    };
}
