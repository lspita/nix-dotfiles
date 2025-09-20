{
  config,
  lib,
  vars,
  ...
}:
lib.custom.mkModule {
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
      wallpapers = lib.custom.wallpapersList config;
      wallpapersDataDir = "gnome-background-properties";
      color = "#000000";
    in
    {
      dconf.settings =
        if builtins.isNull vars.wallpaper then
          { }
        else
          with wallpapers.${vars.wallpaper};
          let
            pathToURI = path: "file://${path}";
            uris =
              if type == "light-dark" then
                {
                  light = pathToURI path.light;
                  dark = pathToURI path.dark;
                }
              else
                let
                  uri = pathToURI path;
                in
                {
                  light = uri;
                  dark = uri;
                };
          in
          {
            "org/gnome/desktop/background" = {
              picture-uri = uris.light;
              picture-uri-dark = uris.dark;
              primary-color = color;
            };
            "org/gnome/desktop/screensaver" = {
              picture-uri = uris.light;
              primary-color = color;
            };
          };
      xdg.dataFile = lib.attrsets.foldlAttrs (
        result: id: properties:
        result
        // {
          "${wallpapersDataDir}/${id}.xml".text =
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
