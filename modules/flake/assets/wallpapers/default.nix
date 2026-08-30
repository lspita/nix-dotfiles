{ lib, assets, ... }: {
  den.schema.host.options.wallpaper = lib.mkOption {
    type = with lib.types; nullOr (enum (builtins.attrNames assets.wallpapers));
    default = null;
    description = "Wallpaper to use";
  };
}
