{
  lib,
  pkgs,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./open-bar.nix {
  config = gnome.mkExtensionConfig {
    package = pkgs.gnomeExtensions.open-bar;
    name = "openbar";
    settings = {
      "" = {
        # auto theming
        autotheme-refresh = true;
        auto-bgalpha = false;
        autofg-bar = true;
        autofg-menu = false;
        smbgoverride = false;
        accent-override = false;
        # bar properties
        bartype = "Mainland";
        # window max-bar
        wmaxbar = false;
        # bar foreground
        font = "Adwaita Sans Bold 11";
        fgalpha = 1.0;
        # bar background
        bgalpha = 0.0;
        # bar highlights
        hpad = 1.0;
        vpad = 3.5;
        # bar border
        bwidth = 0.0;
        neon = false;
        # popup menus
        menustyle = false;
        # shell
        apply-menu-notif = false;
        apply-menu-shell = false;
        apply-accent-shell = false;
        apply-all-shell = false;
        # gtk/flatpak
        headerbar-hint = 0;
        sidebar-hint = 0;
        card-hint = 0;
        view-hint = 0;
        window-hint = 0;
        winbalpha = 0.0;
        winbwidth = 0.0;
        corner-radius = true;
        apply-gtk = false;
        apply-flatpak = false;
      }
      // (optionals.ifNotNull { } (
        with (assets.wallpapers inputs).${vars.wallpaper};
        assets.wallpaperValue type {
          light-dark = {
            autotheme-dark = "Dark";
            autotheme-light = "Light";
          };
          regular = {
            autotheme-dark = "Color";
            autotheme-light = "Color";
          };
        }
      ) vars.wallpaper);
    };
  };
}
