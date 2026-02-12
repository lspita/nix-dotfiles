{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./android-studio.nix {
  options = {
    full.enable = modules.mkEnableOption false "full package";
  };
  config =
    { self, ... }:
    {
      # https://nixos.org/manual/nixpkgs/unstable/#android
      home.packages = lib.lists.singleton (
        with pkgs;
        if self.full.enable then
          android-studio-full
        else
          android-studio
      );
    };
}
