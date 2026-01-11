{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./settings.nix {
  options = {
    vrr.enable = utils.mkEnableOption false "variable refresh rate";
    fractionalScaling.enable = utils.mkEnableOption false "fractional scaling";
    locationServices.enable = utils.mkEnableOption false "location services";
  };
  config =
    { self, ... }:
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
            ++ (if self.vrr.enable then [ "variable-refresh-rate" ] else [ ])
            ++ (
              if self.fractionalScaling.enable then
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
        "org/gnome/shell/app-switcher".current-workspace-only = true;
        "org/gnome/desktop/input-sources".sources = [
          (lib.hm.gvariant.mkTuple [
            "xkb"
            vars.linux.locale.keyboard
          ])
        ];
        "org/gnome/system/location".enabled = self.locationServices.enable;
        "org/gnome/desktop/peripherals/touchpad".disable-while-typing = false;
      };
    };
}
