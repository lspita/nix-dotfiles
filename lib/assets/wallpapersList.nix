{
  root,
  super,
  lib,
  vars,
  flakePath,
}:
config:
let
  wallpaperAssetsDir = "wallpapers";
  wallpapersStaticRoot = flakePath "assets/${wallpaperAssetsDir}";
  wallpapers = lib.attrsets.foldlAttrs (
    result: path: type:
    let
      wallpaperPath = "${super.assetPath config wallpaperAssetsDir}/${path}";
    in
    result
    // (
      if type == "directory" then
        {
          ${path} = {
            type = "light-dark";
            path =
              let
                searchVariant =
                  variant:
                  let
                    matches = builtins.filter (lib.strings.hasPrefix variant) (
                      builtins.attrNames (builtins.readDir "${wallpapersStaticRoot}/${path}")
                    );
                  in
                  if builtins.length matches == 0 then
                    throw "Variant ${variant} not found for wallpaper ${path}"
                  else
                    "${wallpaperPath}/${builtins.head matches}";
              in
              {
                light = searchVariant "light";
                dark = searchVariant "dark";
              };
          };
        }
      else
        {
          ${root.path.fileBasename path} = {
            type = "regular";
            path = wallpaperPath;
          };
        }
    )
  ) { } (builtins.readDir wallpapersStaticRoot);
in
let
  wallpaper = vars.wallpaper;
in
if builtins.isNull wallpaper || builtins.hasAttr wallpaper wallpapers then
  wallpapers
else
  throw "Invalid wallpaper selected: ${wallpaper}"
