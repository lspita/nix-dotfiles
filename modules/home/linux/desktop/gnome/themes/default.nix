{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    (setDefaultSubconfig {
      adw-gtk3.enable = true;
    })
    // (
      # reset to default theme because other de change the gtk theme (e.g. KDE)
      let
        theme = gnome.defaults.theme;
      in
      {
        dconf.settings = {
          "org/gnome/desktop/interface" = {
            cursor-theme = theme;
            icon-theme = theme;
          };
          "org/gnome/desktop/wm/preferences" = {
            inherit theme;
          };
        };
      }
    );
}
