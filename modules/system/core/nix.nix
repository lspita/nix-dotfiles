{
  lib,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./nix.nix {
  options = {
    cleaning = {
      dates = lib.mkOption {
        type = with lib.types; either singleLineStr (listOf str);
        default = "weekly";
        description = "How often the garbage collection is performed.";
      };
      maxGenerations = lib.mkOption {
        type = with lib.types; int;
        default = 5;
        description = "Maximum number of generations to keep.";
      };
    };
    extraSubstituters = lib.mkOption {
      type = with lib.types; listOf attrs;
      default = [ ];
      example = [
        {
          url = "https://nix-community.cachix.org/";
          key = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
        }
      ];
      description = "Extra substituters to use.";
    };
  };
  config =
    { self, ... }:
    {
      nix = {
        settings = lib.mkMerge [
          {
            trusted-users = [ vars.user.username ];
            experimental-features = [
              "nix-command"
              "flakes"
            ];
            auto-optimise-store = true;
            substituters = map (substituter: substituter.url) self.extraSubstituters;
            trusted-public-keys = map (substituter: substituter.key) self.extraSubstituters;
          }
        ];
        gc = with self.cleaning; {
          inherit dates;
          automatic = true;
          options = "--delete-older-than +${toString maxGenerations}";
        };
      };
    };
}
