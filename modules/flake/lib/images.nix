{ lib, ... }: {
  flake.lib.images = {
    imageType =
      {
        tagsWhitelist ? null,
        tagsBlacklist ? [ ],
      }:
      let
        imageData = lib.types.submodule {
          options = {
            path = lib.mkOption {
              type = lib.types.path;
              description = "Path to the image";
            };
            color = lib.mkOption {
              type = with lib.types; nullOr str;
              default = null;
              description = "Main color of the image";
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

        lightDarkData = lib.types.submodule {
          options = {
            light = lib.mkOption {
              type = imageData;
              description = "Image used in light mode";
            };
            dark = lib.mkOption {
              type = imageData;
              description = "Image used in dark mode";
            };
          };
        };

        tagsOptions =
          {
            regular = lib.mkOption {
              type = imageData;
              description = "A single image used in every mode";
            };
            light-dark = lib.mkOption {
              type = lightDarkData;
              description = "Separate images for light and dark mode";
            };
          }
          |> (if isNull tagsWhitelist then lib.id else lib.filterAttrs (t: _: builtins.elem t tagsWhitelist))
          |> lib.filterAttrs (t: _: !builtins.elem t tagsBlacklist);
      in
      lib.types.submodule (
        { name, ... }:
        {
          options = {
            id = lib.mkOption {
              type = lib.types.str;
              default = name;
              description = "Id of the image (defaults to its attribute name)";
            };
            name = lib.mkOption {
              type = lib.types.str;
              description = "Display name of the image";
            };
            image = lib.mkOption {
              type = lib.types.attrTag tagsOptions;
              description = "Image data, tagged by its variant";
            };
          };
        }
      );

    matchTag =
      wallpaper: branches:
      let
        tag = builtins.head (builtins.attrNames wallpaper.image);
      in
      branches.${tag} wallpaper.image.${tag};
  };
}
