{
  config,
  lib,
  vars,
  ...
}:
with lib.custom;
modules.mkModule config ./appsLayout.nix {
  config =
    let
      defaultAppFolders = [
        "Utilities"
        "System"
      ];
    in
    {
      dconf.settings = {
        "org/gnome/shell" = {
          favorite-apps = with vars.linux.defaultApps; [
            browser.desktop
            editor.desktop
            terminal.desktop
            fileManager
            music
          ];
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
