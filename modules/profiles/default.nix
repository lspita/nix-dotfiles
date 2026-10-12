{
  config,
  lib,
  lib2,
  ...
}:
{
  options.profiles = lib.mkOption {
    type = lib.types.attrsOf (lib2.images.imageType { tagsWhitelist = [ "regular" ]; });
    default = { };
    description = "Profile pictures collection";
  };

  config = {
    _module.args.profiles = config.profiles;

    den.schema.user.options.profile.image = lib.mkOption {
      type = with lib.types; nullOr (enum (builtins.attrNames config.profiles));
      default = null;
      description = "Profile image to use";
    };
  };
}
