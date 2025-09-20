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
    "appsLayout"
  ];
  mkConfig =
    { ... }:
    let
      defaultAppFolders = [
        "Utilities"
        "System"
      ];
    in
    {

      dconf.settings = {
        "org/gnome/shell" = {
          favorite-apps =
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
      // (
        # empty default gnome app drawer folders
        builtins.foldl' (
          result: folder: result // { "org/gnome/desktop/app-folders/folders/${folder}".apps = [ ]; }
        ) { } defaultAppFolders
      );
    };
}
