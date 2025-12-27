{
  root,
  super,
  lib,
  vars,
  flakePath,
}:
/*
  {
    [string] = {
      type = "light-dark"
      path: {
        light = string
        dark = string
      }
    } | {
      type = "regular"
      path = string
    }
  }: set with all wallpapers in the assets
*/
inputs: # set: config inputs
let
  wallpaperAssetsDir = "wallpapers";
  wallpapersStaticRoot = flakePath "assets/${wallpaperAssetsDir}";
  wallpapers = lib.attrsets.foldlAttrs (
    result: assetPath: type:
    let
      wallpaperPath = "${super.assetPath inputs wallpaperAssetsDir}/${assetPath}";
    in
    result
    // (
      if type == "directory" then
        {
          ${assetPath} = {
            type = "light-dark";
            path =
              let
                searchVariant =
                  variant:
                  let
                    matches = builtins.filter (lib.strings.hasPrefix variant) (
                      builtins.attrNames (builtins.readDir "${wallpapersStaticRoot}/${assetPath}")
                    );
                  in
                  if builtins.length matches == 0 then
                    throw "Variant ${variant} not found for wallpaper ${assetPath}"
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
          ${root.utils.fileBasename assetPath} = {
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
if isNull wallpaper || builtins.hasAttr wallpaper wallpapers then
  wallpapers
else
  throw "Invalid wallpaper selected: ${wallpaper}"
