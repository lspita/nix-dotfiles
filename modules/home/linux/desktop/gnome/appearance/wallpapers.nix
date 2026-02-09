{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./wallpapers.nix {
  config =
    let
      wallpapers = assets.wallpapers inputs;
      wallpapersDataDir = "gnome-background-properties";
      defaultColor = "#000000";
      wallpaperName = vars.wallpaper;
    in
    {
      dconf.settings =
        if isNull wallpaperName then
          { }
        else
          with wallpapers.${wallpaperName};
          let
            pathToURI = filePath: "file://${filePath}";
            uris = assets.assetTypeValue type {
              light-dark = {
                light = pathToURI light.path;
                dark = pathToURI dark.path;
              };
              regular =
                let
                  uri = pathToURI path;
                in
                {
                  light = uri;
                  dark = uri;
                };
            };
          in
          {
            "org/gnome/desktop/background" = {
              picture-uri = uris.light;
              picture-uri-dark = uris.dark;
              primary-color = defaultColor;
            };
            "org/gnome/desktop/screensaver" = {
              picture-uri = uris.light;
              primary-color = defaultColor;
            };
          };
      xdg.dataFile = lib.attrsets.foldlAttrs (
        result: _: wallpaper:
        result
        // {
          "${wallpapersDataDir}/${wallpaper.id}.xml".text =
            # https://gitlab.gnome.org/GNOME/gnome-backgrounds/-/blob/main/backgrounds/adwaita.xml.in
            ''
              <?xml version="1.0"?>
              <!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
              <wallpapers>
                <wallpaper deleted="false">
                  <name>${wallpaper.id}</name>
                  ${assets.assetTypeValue type {
                    light-dark = ''
                      <filename>${wallpaper.light.path}</filename>
                      <filename-dark>${wallpaper.dark.path}</filename-dark>
                    '';
                    regular = ''
                      <filename>${path}</filename>
                    '';
                  }}
                  <options>zoom</options>
                  <shade_type>solid</shade_type>
                  <pcolor>${defaultColor}</pcolor>
                  <scolor>${defaultColor}</scolor>
                </wallpaper>
              </wallpapers>
            '';
        }
      ) { } wallpapers;
    };
}
