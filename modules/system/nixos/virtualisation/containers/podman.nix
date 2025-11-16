{
  lib,
  pkgs,
  vars,
  ...
}@inputs:
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
    setGroup = utils.mkTrueEnableOption "podman group for the user";
    defaultNetworkDns = utils.mkTrueEnableOption "podman default network DNS";
    docker = {
      replaceSocket = utils.mkTrueEnableOption "docker socket replacement";
      alias = utils.mkTrueEnableOption "podman docker alias";
    };
  };
  config =
    { self, ... }:
    {
      # https://wiki.nixos.org/wiki/Podman
      virtualisation.podman = {
        inherit (self) autoPrune;
        enable = true;
        # Required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings.dns_enabled = self.defaultNetworkDns;
        dockerCompat = self.docker.alias;
        dockerSocket.enable = self.docker.replaceSocket;
      };
      environment.systemPackages = with pkgs; [
        podman-compose
      ];
      users.users.${vars.user.username}.extraGroups = if self.setGroup then [ "podman" ] else [ ];
    };
}
