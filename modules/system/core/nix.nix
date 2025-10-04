{
  config,
  lib,
  vars,
  ...
}:
with lib.custom;
modules.mkModule config ./nix.nix {
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
        };
        gc = with self.cleaning; {
          inherit dates;
          automatic = true;
          options = "--delete-older-than +${builtins.toString maxGenerations}";
        };
      };
    };
}
