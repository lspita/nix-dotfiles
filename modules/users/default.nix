{ den, ... }: {
  den.schema.user = {
    includes = with den.batteries; [ define-user ];
    classes = [ "homeManager" ];
  };
}
