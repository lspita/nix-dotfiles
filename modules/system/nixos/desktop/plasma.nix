{
  config,
  customLib,
  pkgs,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "nixos"
    "desktop"
    "plasma"
  ];
  mkConfig =
    { ... }:
    {
      # # https://nixos.wiki/wiki/KDE
      services.desktopManager.plasma6.enable = true;
      programs.partition-manager.enable = true;
      environment.systemPackages = with pkgs.kdePackages; [
        kcalc
        kcharselect
        kclock
        kcolorchooser
        kolourpaint
        ksystemlog
        isoimagewriter
      ];
    };
}
