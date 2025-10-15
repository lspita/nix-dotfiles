{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./docker.nix {
  options = {
    autoPrune = {
      enable = utils.mkTrueEnableOption "docker auto pruning";
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
    rootless = utils.mkTrueEnableOption "rootless docker";
    setGroup = utils.mkTrueEnableOption "docker group for the user";
  };
  config =
    { self, ... }:
    {
      virtualisation.docker = {
        inherit (self) autoPrune;
        enable = true;
        rootless.enable = self.rootless;
      };
      users.users.${vars.user.username}.extraGroups = if self.setGroup then [ "docker" ] else [ ];
    };
}
