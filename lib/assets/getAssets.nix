{ lib, super }:
# set: assets
inputs: # set: config inputs
dir: # path: directory to search
let
  assetsDir = "${super.assetsRoot}/${dir}";
in
lib.attrsets.foldlAttrs (
  result: asset: _:
  let
    assetPath = "${assetsDir}/${asset}";
    assetMetadata = import "${assetPath}/metadata.nix";
  in
  result // { ${assetMetadata.id} = assetMetadata; }

) { } (lib.attrsets.filterAttrs (_: type: type == "directory") (builtins.readDir assetsDir))
