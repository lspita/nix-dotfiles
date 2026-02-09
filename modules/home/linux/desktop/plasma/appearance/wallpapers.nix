{
  config,
  lib,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./wallpapers.nix {
  options = {
    transition.fade = modules.mkEnableOption true "wallpaper fading transition";
    accentColor.enable = modules.mkEnableOption true "wallpaper accent color";
  };
  config =
    { self, ... }:
    let
      wallpapers = assets.wallpapers inputs;
      wallpapersDataDir = "wallpapers";
      wallpaperName = vars.wallpaper;
      wallpaperPath = "${config.xdg.dataHome}/${wallpapersDataDir}/${wallpaperName}";
    in
    lib.mkMerge [
      (lib.mkIf (!isNull wallpaperName) {
        programs.plasma = {
          workspace.wallpaper = wallpaperPath;
          kscreenlocker.appearance.wallpaper = wallpaperPath;
        };
      })
      {
        # https://www.reddit.com/r/kde/comments/1n9dgoe/comment/nclw0i1/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
        xdg.dataFile = lib.attrsets.foldlAttrs (
          result: _: wallpaper:
          result
          // (
            let
              wallpaperDir = "${wallpapersDataDir}/${wallpaper.id}";
              wallpaperFile =
                { path, size, ... }:
                let
                  extension = files.fileExtension (toString path);
                in
                "${toString size.width}x${toString size.height}.${extension}";
            in
            {
              "${wallpaperDir}/metadata.json".text = builtins.toJSON (
                {
                  KPackageStructure = "Plasma/Wallpaper";
                  KPlugin = {
                    Id = wallpaper.id;
                    Name = wallpaper.name;
                  };
                  X-KDE-CrossFade = self.transition.fade;
                }
                // (
                  let
                    wallpaperColor = wallpaper.color or null;
                  in
                  if (!isNull wallpaperColor && self.accentColor.enable) then
                    {
                      X-KDE-PlasmaImageWallpaper-AccentColor = wallpaperColor;
                    }
                  else
                    { }
                )
              );
            }
            // (assets.assetTypeValue wallpaper {
              light-dark = {
                "${wallpaperDir}/contents/images/${wallpaperFile wallpaper.light}".source = wallpaper.light.path;
                "${wallpaperDir}/contents/images_dark/${wallpaperFile wallpaper.dark}".source = wallpaper.dark.path;
              };
              regular = {
                "${wallpaperDir}/contents/images/${wallpaperFile wallpaper}".source = wallpaper.path;
              };
            })
          )
        ) { } wallpapers;
      }
    ];
}
