{
  lib,
  pkgs,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./hunspell.nix {
  options = {
    extraLanguages = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ ];
      description = "Extra hunspell languages to install";
    };
    preferLarge = modules.mkEnableOption true "large language dictionaries by default";
  };
  config =
    { self, ... }:
    let
      hunspellDicts = pkgs.hunspellDicts;
      getLangDictionary =
        lang:
        let
          largeLang = "${lang}-large";
        in
        if self.preferLarge && (builtins.hasAttr largeLang hunspellDicts) then
          hunspellDicts.${largeLang}
        else
          hunspellDicts.${lang};
      dictionaryPackages = map getLangDictionary (vars.linux.locale.languages ++ self.extraLanguages);
    in
    {
      environment.systemPackages = with pkgs; [ hunspell ] ++ dictionaryPackages;
    };
}
