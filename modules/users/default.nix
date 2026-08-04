{ lib, den, ... }: {
  den.schema.user = {
    includes = [ den.batteries.define-user ];
    classes = lib.mkDefault [ "homeManager" ];
  };
}
