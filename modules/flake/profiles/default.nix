{
  lib,
  lib2,
  flake,
  ...
}:
{
  options.flake.profiles = lib.mkOption {
    type = lib.types.attrsOf (lib2.images.imageType { tagsWhitelist = [ "regular" ]; });
    default = { };
    description = "Profile pictures collection";
  };

  config.den.schema.user.options.profile.image = lib.mkOption {
    type = with lib.types; nullOr (enum (builtins.attrNames flake.assets.profiles));
    default = null;
    description = "Profile image to use";
  };
}
