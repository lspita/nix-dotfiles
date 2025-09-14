{
  config,
  customLib,
  lib,
  vars,
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
  extraOptions = with lib; {
    vrr.enable = mkEnableOption "variable refresh rate";
    fractionalScaling.enable = mkEnableOption "fractional scaling";
    locationServices.enable = mkEnableOption "location services";
  };
  mkConfig =
    { cfg }:
    {
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          gtk-enable-primary-paste = false;
          show-battery-percentage = true;
          enable-hot-corners = false;
        };
        "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,maximize,close";
        "org/gnome/mutter" = {
          center-new-windows = true;
          experimental-features =
            [ ]
            ++ (if cfg.vrr.enable then [ "variable-refresh-rate" ] else [ ])
            ++ (
              if cfg.fractionalScaling.enable then
                [
                  "scale-monitor-framebuffer"
                  "xwayland-native-scaling"
                ]
              else
                [ ]
            );
        };
        "org/gnome/settings-daemon/plugins/color" = {
          # manual night light
          night-light-schedule-from = 0.0;
          night-light-schedule-to = 0.0;
          night-light-temperature = lib.hm.gvariant.mkUint32 3200;
        };
        "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type = "nothing";
        "org/gnome/shell/app-switcher".current-workspace-only = true;
        "org/gnome/desktop/input-sources".sources = [
          (lib.hm.gvariant.mkTuple [
            "xkb"
            vars.linux.locale.keyboard
          ])
        ];
        "org/gnome/system/location".enabled = cfg.locationServices.enable;
      };
    };
}
