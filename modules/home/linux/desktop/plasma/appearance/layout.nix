{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./layout.nix {
  config = {
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
              pager = {
                general = {
                  showWindowOutlines = true;
                  showApplicationIconsOnWindowOutlines = true;
                };
              };
            }
            { panelSpacer = { }; }
            { digitalClock = { }; }
            { panelSpacer = { }; }
            {
              systemTray = {
                items.hidden = [
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
            { kickerdash = { }; }
            {
              iconTasks = {
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
                behavior.unhideOnAttentionNeeded = true;
              };
            }
          ];
        }
      ];
  };
}
