{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./catppuccin.nix {
  config = {
    home.packages = with pkgs; [
      (catppuccin-kde.override {
        flavour = [
          "mocha"
          "latte"
        ];
        accents = [ "sapphire" ];
        winDecStyles = [ "classic" ];
      })
      catppuccin-cursors.mochaLight
      catppuccin-cursors.mochaSapphire
      catppuccin-cursors.latteDark
      catppuccin-cursors.latteSapphire
    ];
    programs.plasma.workspace = {
      theme = "default"; # use breeze and override colors
    }
    // {
      colorScheme = "CatppuccinMochaSapphire";
      cursor.theme = "catppuccin-mocha-sapphire-cursors";
    };
  };
}
