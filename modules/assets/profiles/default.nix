{
  config,
  lib,
  lib2,
  ...
}:
{
  options.meta.assets.profiles = lib.mkOption {
    type = lib.types.attrsOf (lib2.images.imageType { tagsWhitelist = [ "regular" ]; });
    default = { };
    description = "Profile pictures collection";
  };

  config.den.schema.user.options.profile.image = lib.mkOption {
    type = with lib.types; nullOr (enum (builtins.attrNames config.assets.profiles));
    default = null;
    description = "Profile image to use";
  };
}
