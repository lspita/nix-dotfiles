{ den, lib, ... }:
{
  den.schema.host = {
    options.graphics = lib.mkOption {
      type = with lib.types; nullOr (enum (builtins.attrNames den.aspects.graphics));
      default = null;
      description = "Graphics family used by the host";
    };

    includes = [ den.aspects.host.graphics ];
  };

  den.aspects.host.graphics =
    { host, ... }:
    let
      graphicsAspect = den.aspects.graphics.${host.graphics} or { };
    in
    {
      provides.to-users.includes = [ graphicsAspect ];
    };
}
