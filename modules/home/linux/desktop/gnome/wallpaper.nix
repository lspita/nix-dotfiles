{
  config,
  customLib,
  lib,
  vars,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "gnome"
    "wallpaper"
  ];
  mkConfig =
    { ... }:
    let
      wallpapers = customLib.wallpapersList config;
      wallpapersDataDir = "gnome-background-properties";
      color = "#000000";
      bgSettings = "org/gnome/desktop/background";
      ssSettings = "org/gnome/desktop/screensaver";
    in
    {
      dconf.settings =
        lib.recursiveUpdate
          (
            let
              pathToURI = path: "file://${path}";
            in
            with wallpapers.${vars.wallpaper};
            (
              if type == "light-dark" then
                {
                  ${bgSettings} = {
                    picture-uri = pathToURI path.light;
                    picture-uri-dark = pathToURI path.dark;
                  };
                  ${ssSettings}.picture-uri = pathToURI path.light;
                }
              else
                let
                  uri = pathToURI path;
                in
                {
                  ${bgSettings} = {
                    picture-uri = uri;
                  };
                  ${ssSettings}.picture-uri = uri;
                }
            )
          )
          {
            ${bgSettings}.primary-color = color;
            ${ssSettings}.primary-color = color;
          };
      xdg.dataFile = lib.attrsets.foldlAttrs (
        result: name: properties:
        result
        // {
          "${wallpapersDataDir}/${properties.id}.xml".text =
            # https://gitlab.gnome.org/GNOME/gnome-backgrounds/-/blob/main/backgrounds/adwaita.xml.in
            with properties; ''
              <?xml version="1.0"?>
              <!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
              <wallpapers>
                <wallpaper deleted="false">
                  <name>${id}</name>
                  ${
                    if type == "light-dark" then
                      ''
                        <filename>${path.light}</filename>
                        <filename-dark>${path.dark}</filename-dark>
                      ''
                    else
                      ''
                        <filename>${path}</filename>
                      ''
                  }
                  <options>zoom</options>
                  <shade_type>solid</shade_type>
                  <pcolor>${color}</pcolor>
                  <scolor>${color}</scolor>
                </wallpaper>
              </wallpapers>
            '';
        }
      ) { } wallpapers;
    };
}
