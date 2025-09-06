{
  config,
  customLib,
  lib,
  flakeInputs,
  ...
}:
customLib.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "linux"
    "desktop"
    "plasma"
  ];
  imports = [ flakeInputs.plasma-manager.homeModules.plasma-manager ];
  mkConfig =
    { ... }:
    with lib;
    {
      custom.modules.linux.desktop.plasma = {
        settings.enable = mkDefault true;
        appearance = {
          enableDefaults = mkDefault true;
          theme = {
            catppuccin.enable = mkDefault true;
          };
          wallpapers.enable = mkDefault true;
          koi = {
            enable = mkDefault true;
            theme = {
              colors = {
                enable = mkDefault true;
                dark = mkDefault "CatppuccinMochaSapphire";
                light = mkDefault "CatppuccinLatteSapphire";
              };
              cursor = {
                enable = mkDefault true;
                dark = "catppuccin-mocha-light-cursors";
                light = "catppuccin-latte-dark-cursors";
              };
            };
          };
        };
      };
    };
}
