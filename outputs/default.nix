{ nixpkgs, ... }@inputs:
let
  lib = nixpkgs.lib;
in
builtins.foldl' (result: path: lib.attrsets.recursiveUpdate result (import path inputs)) { } (
  builtins.map (f: ./${f}) (
    builtins.attrNames (
      lib.attrsets.filterAttrs (path: _: path != "default.nix") (builtins.readDir ./.)
    )
  )
)
