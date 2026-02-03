{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./layout.nix {
  config = {
    programs.plasma.panels =
      # plasma-org.kde.plasma.desktop-appletsrc
      [
        {
          location = "top";
          lengthMode = "fill";
          height = 32;
          opacity = "translucent";
          hiding = "normalpanel";
          floating = false;
          widgets = [
            {
              name = "org.kde.plasma.pager";
              config = {
                General = {
                  showWindowOutlines = true;
                  showWindowIcons = true;
                };
              };
            }
            "org.kde.plasma.panelspacer"
            "org.kde.plasma.digitalclock"
            "org.kde.plasma.panelspacer"
            "org.kde.plasma.systemtray"
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
          location = "bottom";
          lengthMode = "fit";
          height = 44;
          opacity = "translucent";
          hiding = "dodgewindows";
          floating = true;
          widgets = [
            "org.kde.plasma.kickerdash"
            {
              name = "org.kde.plasma.icontasks";
              config = {
                General = {
                  launchers =
                    with vars.linux.defaultApps;
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
                };
              };
            }
          ];
        }
      ];
  };
}
