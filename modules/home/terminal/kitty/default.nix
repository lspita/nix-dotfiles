{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  options = {
    theme = lib.mkOption {
      type = with lib.types; nullOr str;
      default = null;
      description = "kitty theme";
    };
  };
  config =
    { self, ... }:
    {
      programs.kitty = {
        enable = true;
        settings = {
          term = "xterm-256color"; # xterm-kitty not good for ssh
          touch_scroll_multiplier = 2.0;
        };
      };
      xdg.configFile =
        if builtins.isNull self.theme then
          { }
        else
          let
            kittyConfigDir = "kitty";
            theme = ./themes/${self.theme};
            paths =
              if lib.filesystem.pathIsDirectory theme then
                {
                  dark = "${theme}/dark.conf";
                  light = "${theme}/light.conf";
                }
              else
                {
                  dark = "${theme}.conf";
                  light = "${theme}.conf";
                };
          in
          {
            "${kittyConfigDir}/dark-theme.auto.conf".source = paths.dark;
            "${kittyConfigDir}/light-theme.auto.conf".source = paths.light;
          };
    };
}
