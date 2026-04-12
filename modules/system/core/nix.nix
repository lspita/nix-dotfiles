{
  lib,
  vars,
  options,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./nix.nix {
  options = {
    cleaning = {
      dates = lib.mkOption {
        inherit (options.nix.gc.dates) type description;
        default = "weekly";
      };
      maxLifespan = lib.mkOption {
        type = with lib.types; str;
        default = "7d";
        description = "Maximum lifespan of generations to keep.";
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
        settings = {
          trusted-users = [ vars.user.username ];
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          auto-optimise-store = true;
          substituters = map (substituter: substituter.url) self.extraSubstituters;
          trusted-public-keys = map (substituter: substituter.key) self.extraSubstituters;
          use-xdg-base-directories = true;
        };
        gc = with self.cleaning; {
          inherit dates;
          automatic = true;
          options = "--delete-older-than ${maxLifespan}";
        };
      };
    };
}
