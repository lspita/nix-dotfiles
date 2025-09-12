{
  config,
  customLib,
  vars,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "plasma"
    "appearance"
    "layout"
  ];
  mkConfig =
    { ... }:
    {
      programs.plasma = {
        panels = [
          {
            location = "top";
            lengthMode = "fill";
            height = 32;
            opacity = "translucent";
            hiding = "normalpanel";
            floating = false;
            widgets = [
              "org.kde.plasma.pager"
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
              {
                name = "org.kde.plasma.icontasks";
                config = {
                  General = {
                    launchers =
                      with vars.linux.defaultApps;
                      let
                        ifPackageInstalled =
                          packageName: desktopFile:
                          if builtins.any (p: p.pname == packageName) config.home.packages then [ desktopFile ] else [ ];
                      in
                      builtins.map (app: "applications:${app}") (
                        [
                          browser.desktop
                          editor.desktop
                          terminal.desktop
                          fileManager
                        ]
                        ++ (ifPackageInstalled "spotify" "spotify.desktop")
                      );
                  };
                };
              }
            ];
          }
        ];
      };
    };
}
