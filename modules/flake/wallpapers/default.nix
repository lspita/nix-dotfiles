{
  flake,
  lib,
  lib2,
  ...
}:
{
  options.flake.wallpapers = lib.mkOption {
    type = lib.types.attrsOf (lib2.images.imageType { });
    default = { };
    description = "Wallpapers collection";
  };

  config = {
    den.schema.host.options.wallpaper = lib.mkOption {
      type = with lib.types; nullOr (enum (builtins.attrNames flake.wallpapers));
      default = null;
      description = "Wallpaper to use";
    };

    flake.lib.wallpapers = {
      selected = host: lib2.optionals.fmapNull (w: flake.wallpapers.${w}) host.wallpaper;
    };
  };
}
