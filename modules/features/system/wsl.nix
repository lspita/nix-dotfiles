{ den, lib, ... }: {
  den = {
    aspects = {
      system.wsl = {
        wsl.enable = true;
        nixos.environment.sessionVariables.LD_LIBRARY_PATH = [
          "/usr/lib/wsl/lib"
        ];
      };
      host.wsl-config =
        { host, ... }:
        let
          wslAspect = lib.optionalAttrs host.wsl.enable den.aspects.system.wsl;
        in
        {
          includes = [ wslAspect ];
        };
    };

    schema.host.includes = [ den.aspects.host.wsl-config ];
  };
}
