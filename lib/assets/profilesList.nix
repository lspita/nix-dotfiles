{
  root,
  super,
  lib,
  vars,
  flakePath,
}:
config:
let
  profilesAssetsDir = "profiles";
  profilesStaticRoot = flakePath "assets/${profilesAssetsDir}";
  profiles = lib.attrsets.foldlAttrs (
    result: path: type:
    result
    // {
      ${root.path.fileBasename path} = "${super.assetPath config profilesAssetsDir}/${path}";
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
