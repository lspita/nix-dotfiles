{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig {
      # reset to default theme because other DEs change the gtk theme (e.g. KDE)
      cursors.adwaita.enable = true;
      icons.adwaita.enable = true;
      shell.adwaita.enable = true;
      gtk3.adw-gtk3.enable = true;
    };
}
