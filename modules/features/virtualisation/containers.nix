{ den, lib, ... }: {
  den.aspects.virtualisation.containers =
    preferredPlatform:
    let
      platforms = {
        podman = {
          aspect = den.aspects.virtualisation.podman or { };
          backend = "podman";
          compose = (pkgs: pkgs.podman-compose);
        };
        docker = {
          aspect = den.aspects.virtualisation.docker;
          backend = "docker";
          compose = (pkgs: pkgs.docker-compose);
        };
      };
      platform = platforms.${preferredPlatform};
    in
    {
      includes = [ platform.aspect ];

      nixos =
        { pkgs, ... }:
        let
          compose-package = platform.compose pkgs;
        in
        {
          virtualisation = {
            containers = {
              enable = true;
              containersConf.settings = {
                engine.compose_providers = [ (lib.getExe compose-package) ];
              };
            };
            oci-containers.backend = platform.backend;
          };
          environment.systemPackages = [ compose-package ];
        };
    };
}
