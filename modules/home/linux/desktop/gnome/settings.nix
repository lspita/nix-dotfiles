{
  config,
  customLib,
  pkgs,
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
      };
    };
}
