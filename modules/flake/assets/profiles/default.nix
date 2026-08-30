{ lib, assets, ... }: {
  den.schema.user.options.profile.image = lib.mkOption {
    type = with lib.types; nullOr (enum (builtins.attrNames assets.profiles));
    default = null;
    description = "Profile image to use";
  };
}
