{ den, lib, ... }: {
  den = {
    schema.user = {
      options = {
        shell = lib.mkOption {
          type = lib.types.str;
          description = "Shell used by the user.";
        };
        fullName = lib.mkOption {
          type = with lib.types; nullOr str;
          default = null;
          description = "Full name of the user";
        };
        email = lib.mkOption {
          type = with lib.types; nullOr str;
          default = null;
          description = "Email name of the user";
        };
      };

      includes = with den.aspects; [ user ];
      config.classes = [ "homeManager" ];
    };
    aspects.user =
      { user, ... }:
      let
        shellName = user.shell;
        userShell = den.batteries.user-shell shellName;
        shellAspect = den.aspects.shell.${shellName};
      in
      {
        includes = [
          userShell
          shellAspect
        ]
        ++ (with den.batteries; [
          host-aspects
          define-user
          primary-user
        ]);
      };
  };

  flake.users = lib.mkOption {
    type = lib.types.attrs;
    default = { };
    description = "Users defaults definitions";
  };
}
