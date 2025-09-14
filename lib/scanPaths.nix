{ lib }:
# https://github.com/ryan4yin/nix-config/blob/c56593516d8309557f4b74e60add8e2a36f0bf95/lib/default.nix#L16
path:
builtins.map (f: (path + "/${f}")) (
  builtins.attrNames (
    lib.attrsets.filterAttrs (
      path: type:
      (type == "directory") # include directories
      || (
        (path != "default.nix") # ignore default.nix
        && (lib.strings.hasSuffix ".nix" path) # include .nix files
      )
    ) (builtins.readDir path)
  )
)
