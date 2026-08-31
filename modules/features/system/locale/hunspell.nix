{ lib, ... }: {
  den = {
    schema.host.options.locale.languages = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ ];
      description = "Languages to install";
    };

    aspects.system.locale.hunspell.os =
      { host, pkgs, ... }:
      let
        hunspellDicts = pkgs.hunspellDicts;
        getLangDictionary =
          lang:
          let
            largeLang = "${lang}-large";
          in
          if (builtins.hasAttr largeLang hunspellDicts) then
            hunspellDicts.${largeLang}
          else
            hunspellDicts.${lang};
        dictionaryPackages = map getLangDictionary host.locale.languages;
      in
      {
        environment.systemPackages = with pkgs; [ hunspell ] ++ dictionaryPackages;
      };
  };
}
