{ nixpkgs, ... }@inputs:
let
  lib = nixpkgs.lib;
  listDir =
    {
      dirPath,
      filterfn ? (filepath: _: filepath != "default.nix"),
    }:
    builtins.attrNames (lib.attrsets.filterAttrs filterfn (builtins.readDir dirPath));
in
builtins.foldl'
  (
    result: filePath:
    lib.attrsets.recursiveUpdate result (import filePath (inputs // { inherit lib listDir; }))
  )
  { }
  (
    map (f: ./${f}) (listDir {
      dirPath = ./.;
    })
  )
