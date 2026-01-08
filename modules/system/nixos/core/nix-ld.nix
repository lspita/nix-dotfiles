{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./nix-ld.nix {
  options = { };
  config = {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
        stdenv.cc.cc.lib
      ];
    };
  };
}
