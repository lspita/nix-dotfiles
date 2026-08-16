{ den, ... }: {
  den.aspects.nix = {
    includes = with den.aspects; [
      nix.nix-community
    ];

    os =
      { user, ... }:
      {
        nix = {
          settings = {
            trusted-users = [ user.userName ];
            experimental-features = [
              "nix-command"
              "flakes"
            ];
            auto-optimise-store = true;
            use-xdg-base-directories = true;
          };
          gc = {
            dates = "weekly";
            automatic = true;
            options = "--delete-older-than 7d";
          };
        };
      };

    nix-community.os.nix.settings = {
      # https://app.cachix.org/cache/nix-community
      substituers = [ "https://nix-community.cachix.org/" ];
      trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
    };
  };
}
