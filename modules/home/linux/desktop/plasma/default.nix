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
      programs.plasma.enable = true;
      custom.modules.linux.desktop.plasma = {
        settings.enable = mkDefault true;
        virtualKeyboard.enable = mkDefault true;
        plugin = {
          dynamicWorkspaces.enable = mkDefault true;
        };
        appearance = {
          enableDefaults = mkDefault true;
          layout.enable = mkDefault true;
          theme = {
            catppuccin.enable = mkDefault true;
          };
          wallpapers = {
            enable = mkDefault true;
            selected = mkDefault "mountains";
          };
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
              gtk = {
                enable = mkDefault true;
                dark = "Breeze";
                light = "Breeze";
              };
            };
          };
        };
      };
    };
}
