{
  config,
  lib,
  vars,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "nix"
  ];
  extraOptions = {
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
  };
  mkConfig =
    { cfg }:
    {
      nix = {
        settings = {
          trusted-users = [ vars.user.username ];
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          auto-optimise-store = true;
        };
        gc = with cfg.cleaning; {
          inherit dates;
          automatic = true;
          options = "--delete-older-than +${builtins.toString maxGenerations}";
        };
      };
    };
}
