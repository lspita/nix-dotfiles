{ lib, den, ... }: {
  den = {
    schema.host = {
      options = {
        graphics = lib.mkOption {
          type =
            with lib.types;
            nullOr (enum [
              "nvidia"
              "intel"
              "amd"
            ]);
          default = null;
          description = "Graphics family used by the host";
        };
        stateVersion = lib.mkOption {
          type = lib.types.str;
          description = "State version of the system.";
        };
      };

      includes = with den.aspects; [ host ];
    };

    aspects.host =
      { host, ... }:
      let
        graphicsAspect = den.aspects.graphics.${host.graphics} or { };
        wslAspect = lib.optionalAttrs host.wsl.enable den.aspects.system.wsl;
      in
      {
        includes = with den.batteries; [
          hostname
          graphicsAspect
          wslAspect
        ];

        os.system.stateVersion = host.stateVersion;
        provides.to-users = {
          includes = [ graphicsAspect ];
          homeManager.home.stateVersion = host.stateVersion;
        };
      };
  };
}
