{ den, lib, ... }: {
  den.aspects.nix =
    let
      mkNixSettingsAspect =
        section: settings:
        let
          nixConfig = {
            ${section} = settings;
          };
        in
        {
          os.nix = nixConfig;
          homeManager =
            {
              osConfig ? null,
              ...
            }:
            lib.optionalAttrs (isNull osConfig) { nix = nixConfig; };
        };
    in
    {
      settings = mkNixSettingsAspect "settings";
      gc = mkNixSettingsAspect "gc";

      includes = with den.aspects; [
        nix.nix-community
        ({ user, ... }: {
          includes = [
            (nix.settings {
              trusted-users = [ user.userName ];
              experimental-features = [
                "nix-command"
                "flakes"
                "pipe-operators"
              ];
              auto-optimise-store = true;
              use-xdg-base-directories = true;
            })
            (nix.gc {
              dates = "weekly";
              automatic = true;
              options = "--delete-older-than 7d";
            })
          ];
        })
      ];

      homeManager =
        {
          pkgs,
          osConfig ? null,
          ...
        }:
        lib.optionalAttrs (isNull osConfig) {
          nix.package = pkgs.nix;
        };

      nix-community.includes = with den.aspects; [
        (nix.settings {
          # https://app.cachix.org/cache/nix-community
          substituers = [ "https://nix-community.cachix.org/" ];
          trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
        })
      ];
    };
}
