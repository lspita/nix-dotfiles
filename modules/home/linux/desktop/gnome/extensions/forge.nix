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
    "extensions"
    "forge"
  ];
  mkConfig =
    { ... }:
    lib.attrsets.recursiveUpdate
      (lib.custom.gnome.mkExtensionConfig {
        package = pkgs.gnomeExtensions.forge;
        settings = {
          "" = {
            focus-border-toggle = false;
            auto-split-enabled = true;
            stacked-tiling-mode-enabled = false;
            abbed-tiling-mode-enabled = false;
            dnd-center-layout = "swap";
          };
          "keybindings" = {
            window-focus-down = [ "<Control><Super>Down" ];
            window-focus-left = [ "<Control><Super>Left" ];
            window-focus-right = [ "<Control><Super>Right" ];
            window-focus-up = [ "<Control><Super>Up" ];
            window-swap-down = [ "<Control><Shift><Super>Down" ];
            window-swap-left = [ "<Control><Shift><Super>Left" ];
            window-swap-right = [ "<Control><Shift><Super>Right" ];
            window-swap-up = [ "<Control><Shift><Super>Up" ];
            window-toggle-float = [ "<Super>f" ];
            window-toggle-always-float = [ "<Shift><Super>f" ];
            window-active-tile-toggle = [ "<Super>a" ];
            window-swap-last-active = [ ];
            window-gap-size-decrease = [ ];
            window-gap-size-increase = [ ];
            window-move-down = [ ];
            window-move-left = [ ];
            window-move-right = [ ];
            window-move-up = [ ];
            prefs-open = [ ];
          };
        };
      })
      {
        dconf.settings."org/gnome/shell/keybindings".toggle-application-view = [ ]; # Super+A used for active tile toggle
      };
}
