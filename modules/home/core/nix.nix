{
  config,
  customLib,
  lib,
  vars,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "core"
    "nix"
  ];
  mkConfig =
    { ... }:
    {
      nix = with lib; {
        settings = {
          trusted-users = [ vars.user.username ];
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
        gc = {
          automatic = true;
          dates = mkDefault "weekly";
          options = mkDefault "--delete-older-than 7d";
        };
      };
    };
}
