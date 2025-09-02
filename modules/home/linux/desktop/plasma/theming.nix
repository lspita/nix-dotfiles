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
    "theming"
  ];
  mkConfig =
    { ... }:
    let
      koiPackage = pkgs.kdePackages.koi; # theme switcher https://github.com/baduhai/Koi
    in
    {
      home.packages =
        with pkgs.kdePackages;
        [
          koiPackage
          kde-gtk-config
        ]
        ++ (
          let
            flavours = [
              "mocha"
              "latte"
            ];
            accents = [
              "mauve"
              "sapphire"
            ];
          in
          with pkgs;
          [
            (catppuccin-kde.override {
              flavour = flavours;
              accents = accents;
            })
          ]
          ++ (builtins.map (variant: catppuccin-gtk.override { inherit variant accents; }) flavours)
        );
      xdg = {
        autostart.entries = [ "${koiPackage}/share/applications/local.KoiDbusInterface.desktop" ];
      };
      programs.plasma = {
        workspace.lookAndFeel = "org.kde.breezedark.desktop"; # fallback
        configFile = {
          koirc = {
            General = {
              notify.value = 2; # enabled
              schedule.value = 0; # disabled
              start-hidden.value = 2; # enabled
            };
            # Koi doesn't recognize these themes, if you press "save" in the app preferences
            # it overwrites with defaults. With the "immutable" option enabled for the keys
            # it doesn't recognize them anymore and says you have empty values.
            ColorScheme = {
              # plasma-apply-colorscheme --list-schemes
              enabled.value = true;
              dark.value = "CatppuccinMochaSapphire";
              light.value = "CatppuccinLatteSapphire";
            };
            GTKTheme = {
              enabled.value = true;
              dark.value = "catppuccin-mocha-sapphire-standard";
              light.value = "catppuccin-latte-sapphire-standard";
            };
            KvantumStyle.enabled.value = false;
            IconTheme.enabled.value = false;
            Script.enabled.value = false;
            Wallpaper.enabled.value = false;
          };
        };
      };
    };
}
