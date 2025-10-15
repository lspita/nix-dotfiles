{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./podman.nix {
  options = {
    autoPrune = {
      enable = utils.mkTrueEnableOption "podman auto pruning";
      dates = lib.mkOption {
        type = with lib.types; str;
        default = "weekly";
        description = "Specification (in the format described by systemd.time(7)) of the time at which the prune will occur.";
      };
      flags = lib.mkOption {
        type = with lib.types; listOf str;
        default = [ "--all" ];
        description = "Any additional flags passed to the prune command.";
      };
    };
  };
  config =
    { self, ... }:
    {
      virtualisation.podman = {
        inherit (self) autoPrune;
        enable = true;
      };
    };
}
