{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./open-bar.nix {
  config = gnome.mkExtensionConfig {
    package = pkgs.gnomeExtensions.open-bar;
    name = "openbar";
    settings = {
      "" = {
        # auto theming
        autotheme-refresh = true;
        autotheme-dark = "Color";
        autotheme-light = "Color";
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
        # headerbar-hint = 0;
        # sidebar-hint = 0;
        # card-hint = 0;
        # view-hint = 0;
        # window-hint = 0;
        # winbwidth = 0.0; # window border width
        # corner-radius = true;
        apply-gtk = false;
        apply-flatpak = false;
      };
    };
  };
}
