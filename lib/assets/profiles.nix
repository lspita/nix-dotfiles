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
    result: path: type:
    result
    // {
      ${root.utils.fileBasename path} = "${super.assetPath inputs profilesAssetsDir}/${path}";
    }
  ) { } (builtins.readDir profilesStaticRoot);
in
let
  image = vars.user.image;
in
if builtins.isNull image || builtins.hasAttr image profiles then
  profiles
else
  throw "Invalid profile selected: ${builtins.toString image}"
