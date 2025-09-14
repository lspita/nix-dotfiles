{
  config,
  lib,
  vars,
  pkgs,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "gnome"
    "dock"
  ];
  mkConfig =
    { ... }:
    {
      dconf.settings."org/gnome/shell".favorite-apps =
        with vars.linux.defaultApps;
        [
          browser.desktop
          editor.desktop
          terminal.desktop
          fileManager
        ]
        ++ (if builtins.elem pkgs.spotify config.home.packages then [ "spotify.desktop" ] else [ ]);
    };
}
