{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./config.nix {
  config = {
    virtualisation.containers = {
      enable = true;
      registries.search = [ "docker.io" ];
    };
  };
}
