{
  lib,
  pkgs,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./docker.nix {
  options = {
    autoPrune = {
      enable = utils.mkEnableOption true "docker auto pruning";
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
    setGroup = utils.mkEnableOption true "docker group for the user";
  };
  config =
    { self, ... }:
    {
      virtualisation.docker = {
        inherit (self) autoPrune;
        enable = true;
      };
      environment.systemPackages = with pkgs; [
        docker-compose
      ];
      users.users.${vars.user.username}.extraGroups = if self.setGroup then [ "docker" ] else [ ];
    };
}
