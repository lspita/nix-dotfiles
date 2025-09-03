{
  config,
  customLib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "plasma"
    "appearance"
    "wallpapers"
  ];
  mkConfig =
    { ... }:
    let
      selected = "Mountains";
      wallpapersDataDir = "wallpapers";
      wallpapers = [
        {
          id = "Mountains";
          dir = "mountains";
          size = "3840x2160";
        }
      ];
    in
    {
      programs.plasma =
        let
          wallpaperPath = "${config.xdg.dataHome}/${wallpapersDataDir}/${selected}";
        in
        {
          workspace.wallpaper = wallpaperPath;
          kscreenlocker.appearance.wallpaper = wallpaperPath;
        };
    }
    // (builtins.foldl' (
      result:
      {
        id,
        name ? id,
        dir,
        fileExtension ? "png",
        size,
        version ? "1.0",
        fade ? true,
      }:
      result
      // (
        let
          wallpaperDataRoot = "${wallpapersDataDir}/${id}";
          contentsRoot = "${wallpaperDataRoot}/contents";
        in
        {
          xdg.dataFile = {
            "${wallpaperDataRoot}/metadata.json".text = ''
              {
                "KPlugin": {
                  "Id": ${builtins.toJSON id},
                  "Name": ${builtins.toJSON name},
                  "Version": ${builtins.toJSON version}
                },
                "X-KDE-CrossFade": ${builtins.toJSON fade}
              }
            '';
            "${contentsRoot}/images/${size}.${fileExtension}".source = config.lib.file.mkOutOfStoreSymlink (
              customLib.assetPath config "wallpapers/${dir}/light.${fileExtension}"
            );
            "${contentsRoot}/images_dark/${size}.${fileExtension}".source =
              config.lib.file.mkOutOfStoreSymlink (
                customLib.assetPath config "wallpapers/${dir}/dark.${fileExtension}"
              );
          };
        }
      )
    ) { } wallpapers);
}
