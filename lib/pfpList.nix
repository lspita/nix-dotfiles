{
  root,
  lib,
  vars,
  flakePath,
}:
config:
let
  pfpAssetsDir = "pfp";
  pfpStaticRoot = flakePath "assets/${pfpAssetsDir}";
  pfp = lib.attrsets.foldlAttrs (
    result: path: type:
    result
    // {
      ${root.fileBasename path} = "${root.assetPath config pfpAssetsDir}/${path}";
    }
  ) { } (builtins.readDir pfpStaticRoot);
in
let
  image = vars.user.image;
in
if builtins.isNull image || builtins.hasAttr image pfp then
  pfp
else
  throw "Invalid pfp selected: ${image}"
