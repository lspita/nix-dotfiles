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
  extraOptions = {
    gc = {
      dates = lib.mkOption {
        type = lib.types.str;
        default = "weekly";
        description = "How often or when garbage collection is performed.";
      };
      options = lib.mkOption {
        type = lib.types.str;
        default = "--delete-older-than 7d";
        description = "Options given to nix-collect-garbage when the garbage collector is run automatically.";
      };
    };
  };
  mkConfig =
    { cfg }:
    {
      nix = {
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
        gc = {
          automatic = true;
          inherit (cfg.gc) dates options;
        };
      };
    };
}
