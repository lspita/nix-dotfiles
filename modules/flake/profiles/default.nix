{ lib, flake, ... }: {
  options.flake.profiles = lib.mkOption {
    type = lib.types.attrs;
    default = { };
    description = "Profile pictures collection";
  };

  config.den.schema.user.options.profile.image = lib.mkOption {
    type = with lib.types; nullOr (enum (builtins.attrNames flake.assets.profiles));
    default = null;
    description = "Profile image to use";
  };
}
