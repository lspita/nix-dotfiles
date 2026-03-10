{
  config,
  lib,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./layout.nix {
  config = {
    # Prevent race condition in loading panels because of screen = "all"
    # https://github.com/nix-community/plasma-manager/issues/577
    programs.plasma.startup.desktopScript."panels".preCommands = lib.mkForce ''
      sleep 3
      [ -f ${config.xdg.configHome}/plasma-org.kde.plasma.desktop-appletsrc ] && rm ${config.xdg.configHome}/plasma-org.kde.plasma.desktop-appletsrc
    '';
    programs.plasma.panels =
      # plasma-org.kde.plasma.desktop-appletsrc
      # https://github.com/nix-community/plasma-manager/tree/trunk/modules/widgets
      [
        {
          screen = "all";
          location = "top";
          lengthMode = "fill";
          height = 32;
          opacity = "adaptive";
          hiding = "normalpanel";
          floating = true;
          widgets = [
            {
              name = "org.kde.plasma.pager";
              config = {
                General = {
                  showWindowIcons = true;
                  showWindowOutlines = true;
                };
              };
            }
            {
              name = "org.kde.plasma.panelspacer";
            }
            { name = "org.kde.plasma.digitalclock"; }
            { name = "org.kde.plasma.panelspacer"; }
            {
              name = "org.kde.plasma.systemtray";
              config = {
                General.hiddenItems = [
                  "org.kde.plasma.clipboard"
                ];
              };
            }
            {
              name = "org.kde.plasma.userswitcher";
              config = {
                General = {
                  showFace = true;
                  showName = false;
                };
              };
            }
          ];
        }
        {
          screen = "all";
          location = "bottom";
          lengthMode = "fit";
          height = 44;
          opacity = "adaptive";
          hiding = "dodgewindows";
          floating = true;
          widgets = [
            {
              name = "org.kde.plasma.kickerdash";
              config = {
                General.forceDarkMode = false;
              };
            }
            {
              name = "org.kde.plasma.icontasks";
              config = {
                General = {
                  launchers =
                    with vars.defaultApps;
                    let
                      plasmaApps = plasma.defaults.apps;
                    in
                    map (app: "applications:${app.desktop}") (
                      builtins.filter (app: !(isNull app)) [
                        browser
                        editor
                        (optionals.getNotNull plasmaApps.terminal terminal)
                        (optionals.getNotNull plasmaApps.fileManager fileManager)
                        music
                      ]
                    );
                  unhideOnAttention = true;
                };
              };
            }
          ];
        }
      ];
  };
}
