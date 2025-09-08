{
  config,
  customLib,
  pkgs,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "plasma"
    "appearance"
    "theme"
    "catppuccin"
  ];
  mkConfig =
    { ... }:
    {
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
        catppuccin-cursors.latteDark
      ];
      programs.plasma.workspace.theme = "default";
    };
}
