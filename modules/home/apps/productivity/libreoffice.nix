{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./libreoffice.nix {
  options = {
    spellcheck.enable = modules.mkEnableOption true "spellcheck";
  };
  config =
    { self, ... }:
    {
      home.packages =
        with pkgs;
        lib.mkMerge [
          [ libreoffice-fresh ]
          (lib.mkIf self.spellcheck.enable [
            hunspell
            # TODO: spellcheckers based on languages
          ])
        ];
    };
}
