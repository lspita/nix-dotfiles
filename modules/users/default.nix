{ den, ... }: {
  den.schema.user = {
    includes = with den.batteries; [
      host-aspects
      define-user
    ];
    classes = [ "homeManager" ];
  };
}
