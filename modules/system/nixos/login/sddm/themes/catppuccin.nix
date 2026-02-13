{
  lib,
  pkgs,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./catppuccin.nix {
  options = {
    flavor = lib.mkOption {
      type = with lib.types; str;
      default = "mocha";
      description = "catppuccin flavor";
    };
    accent = lib.mkOption {
      type = with lib.types; str;
      default = "sapphire";
      description = "catppuccin accent";
    };
  };
  config =
    { self, ... }:
    {
      # https://github.com/catppuccin/sddm?tab=readme-ov-file#nixos
      environment.systemPackages =
        let
          font = vars.fonts.normal;
          wallpapers = assets.wallpapers inputs;
          wallpaperName = vars.wallpaper;
          wallpaper = wallpapers.${wallpaperName};
        in
        [
          (pkgs.catppuccin-sddm.override (
            {
              inherit (self) flavor accent;
              font = font.name;
              fontSize = toString font.size;
              clockEnabled = false;
            }
            // (lib.attrsets.optionalAttrs (!isNull wallpaperName) {
              background = assets.assetTypeValue wallpaper {
                light-dark = (if self.flavor == "latte" then wallpaper.light else wallpaper.dark).path;
                regular = wallpaper.path;
              };
            })
          ))
        ];
      services.displayManager.sddm.theme = "catppuccin-${self.flavor}-${self.accent}";
    };
}
