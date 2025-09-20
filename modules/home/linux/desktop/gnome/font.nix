{
  config,
  lib,
  vars,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "gnome"
    "font"
  ];
  mkConfig =
    { ... }:
    with lib.custom;
    with vars.fonts;
    let
      normalFont = fontString normal;
      monospaceFont = fontString monospace;
    in
    {
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          font-name = normalFont;
          document-font-name = normalFont;
          monospace-font-name = monospaceFont;
        };
      };
    };
}
