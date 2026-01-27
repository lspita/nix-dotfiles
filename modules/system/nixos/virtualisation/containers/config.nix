{ options, lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./config.nix {
  options = {
    backend = lib.mkOption {
      type = with lib.types; nullOr str;
      default = null;
      description = "The container backend to use.";
    };
    composeProviders = lib.mkOption {
      type = with lib.types; nullOr (listOf str);
      default = null;
      description = "The container backend to use for compose files.";
    };
  };
  config =
    { self, ... }:
    {
      virtualisation = {
        containers = {
          enable = true;
          registries.search = [ "docker.io" ];
          containersConf.settings = (
            optionals.ifNotNull { } {
              compose_providers = self.composeProviders;
            } self.composeProviders
          );
        };
        oci-containers.backend = optionals.getNotNull options.virtualisation.oci-containers.backend self.backend;
      };
    };
}
