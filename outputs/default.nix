{ nixpkgs, ... }@inputs:
let
  lib = nixpkgs.lib;
  listDir =
    {
      path,
      filter ? (path: _: path != "default.nix"),
    }:
    builtins.attrNames (lib.attrsets.filterAttrs filter (builtins.readDir path));
in
builtins.foldl'
  (
    result: path: lib.attrsets.recursiveUpdate result (import path (inputs // { inherit lib listDir; }))
  )
  { }
  (
    builtins.map (f: ./${f}) (listDir {
      path = ./.;
    })
  )
