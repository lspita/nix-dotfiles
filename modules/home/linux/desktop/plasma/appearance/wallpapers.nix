{
  config,
  customLib,
  lib,
  ...
}:
let
  wallpapers = [
    {
      id = "mountains";
      name = "Mountains";
      dir = "mountains";
      size = "3840x2160";
    }
    {
      id = "material-tux";
      name = "Material Tux";
      file = "material-tux.png";
      size = "4936x2784";
    }
  ];
in
customLib.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "plasma"
    "appearance"
    "wallpapers"
  ];
  extraOptions = {
    selected = lib.mkOption {
      type = lib.types.enum (builtins.map (w: w.id) wallpapers);
      description = "The selected wallpaper.";
    };
  };
  mkConfig =
    { cfg }:
    let
      wallpapersDataDir = "wallpapers";
      wallpapersAssetsDir = "wallpapers";
    in
    {
      programs.plasma =
        let
          wallpaperPath = "${config.xdg.dataHome}/${wallpapersDataDir}/${cfg.selected}";
        in
        {
          workspace.wallpaper = wallpaperPath;
          kscreenlocker.appearance.wallpaper = wallpaperPath;
        };
      xdg.dataFile = (
        builtins.foldl' (
          result:
          {
            id,
            name ? id,
            file ? null,
            dir ? null,
            fileExtension ? "png",
            size,
            version ? "1.0",
            fade ? true,
          }:
          if
            (builtins.isNull dir && builtins.isNull file) || (!builtins.isNull dir && !builtins.isNull file)
          then
            throw "Either file or dir+fileExtension exclusively must be provided for a wallpaper"
          else
            result
            // (
              let
                wallpaperDataRoot = "${wallpapersDataDir}/${id}";
                contentsRoot = "${wallpaperDataRoot}/contents";
              in
              {
                "${wallpaperDataRoot}/metadata.json".text = ''
                  {
                    "KPlugin": {
                      "Id": ${builtins.toJSON id},
                      "Name": ${builtins.toJSON name},
                      "Version": ${builtins.toJSON version}
                    }${if builtins.isNull dir then "" else ", \"X-KDE-CrossFade\": ${builtins.toJSON fade}"}
                  }
                '';
                "${contentsRoot}/images/${size}.${fileExtension}".source = config.lib.file.mkOutOfStoreSymlink (
                  customLib.assetPath config "${wallpapersAssetsDir}/${
                    if !builtins.isNull file then "${file}" else "${dir}/light.${fileExtension}"
                  }"
                );
              }
              // (
                if builtins.isNull dir then
                  { }
                else
                  {
                    "${contentsRoot}/images_dark/${size}.${fileExtension}".source =
                      config.lib.file.mkOutOfStoreSymlink (
                        customLib.assetPath config "${wallpapersAssetsDir}/${dir}/dark.${fileExtension}"
                      );
                  }
              )
            )
        ) { } wallpapers
      );
    };
}
