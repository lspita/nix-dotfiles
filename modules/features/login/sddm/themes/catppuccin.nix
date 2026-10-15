{ lib, lib2, ... }: {
  den.aspects.login.sddm.themes.catppuccin.nixos =
    { host, pkgs, ... }:
    let
      cfg = host.themes.catppuccin;
      font = host.fonts.normal;
      wallpaper = lib2.assets.wallpapers.selected host;
      sddm-pkg =
        # https://github.com/catppuccin/sddm?tab=readme-ov-file#nixos
        pkgs.catppuccin-sddm.override (
          {
            inherit (cfg) flavor accent;
            font = font.name;
            fontSize = toString font.size;
            clockEnabled = false;
            loginBackground = true;
          }
          // (lib.attrsets.optionalAttrs (!isNull wallpaper) (
            let
              wallpaperImage = lib2.images.matchTag wallpaper {
                regular = lib.id;
                light-dark = { light, dark }: if cfg.flavor == "latte" then light else dark;
              };
            in
            {
              background = wallpaperImage.path;
            }
          ))
        );
    in
    {
      environment.systemPackages = [ sddm-pkg ];
      services.displayManager.sddm.theme = "catppuccin-${cfg.flavor}-${cfg.accent}";
    };
}
