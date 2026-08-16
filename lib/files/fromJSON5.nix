{ lib, pkgs }:
# json: parsed json5
jsonString: # string: json input
builtins.fromJSON (
  builtins.readFile (
    pkgs.runCommand "fromJSON5" { } ''
      echo ${lib.escapeShellArg jsonString} | ${pkgs.fixjson}/bin/fixjson > $out
    ''
  )
)
