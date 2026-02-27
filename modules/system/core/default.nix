{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig {
      nix = {
        enable = true;
        extraSubstituters =
          # https://wiki.nixos.org/wiki/CUDA#Setting_up_CUDA_Binary_Cache
          (lib.lists.optional vars.nixpkgs.config.cudaSupport {
            url = "https://cache.nixos-cuda.org";
            key = "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=";
          })
          ++ [
            # https://app.cachix.org/cache/nix-community
            {
              url = "https://nix-community.cachix.org/";
              key = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
            }
          ];
      };
      user.enable = true;
    };
}
