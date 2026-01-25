{
  root,
  super,
  lib,
  vars,
  flakePath,
}:
# { [string] = string }: set with all profile pictures in the assets
inputs: # set: config inputs
let
  profilesAssetsDir = "profiles";
  profilesStaticRoot = flakePath "assets/${profilesAssetsDir}";
  profiles = lib.attrsets.foldlAttrs (
    result: profilePath: type:
    result
    // {
      ${root.files.fileBasename profilePath} =
        "${super.assetPath inputs profilesAssetsDir}/${profilePath}";
    }
  ) { } (builtins.readDir profilesStaticRoot);
in
let
  image = vars.user.image;
in
if isNull image || builtins.hasAttr image profiles then
  profiles
else
  throw "Invalid profile selected: ${toString image}"
