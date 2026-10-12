{ lib, flake, ... }:
let
  profileType = lib.types.submodule {
    options = {
      id = lib.mkOption {
        type = lib.types.str;
        description = "Id of the image";
      };
      name = lib.mkOption {
        type = lib.types.str;
        description = "Display name of the image";
      };
      path = lib.mkOption {
        type = lib.types.path;
        description = "Path to the image";
      };
      size = {
        width = lib.mkOption {
          type = lib.types.ints.positive;
          description = "Width of the image";
        };
        height = lib.mkOption {
          type = lib.types.ints.positive;
          description = "Height of the image";
        };
      };
    };
  };
in
{
  options.flake.profiles = lib.mkOption {
    type = lib.types.attrsOf profileType;
    default = { };
    description = "Profile pictures collection";
  };

  config.den.schema.user.options.profile.image = lib.mkOption {
    type = with lib.types; nullOr (enum (builtins.attrNames flake.assets.profiles));
    default = null;
    description = "Profile image to use";
  };
}
