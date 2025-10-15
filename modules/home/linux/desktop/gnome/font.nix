{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./font.nix {
  config =
    with vars.fonts;
    let
      normalFont = utils.ifNotNull normal null (utils.fontString normal);
      monospaceFont = utils.ifNotNull monospace null (utils.fontString monospace);
    in
    {
      dconf.settings = {
        "org/gnome/desktop/interface" =
          (utils.ifNotNull normalFont { } {
            font-name = normalFont;
            document-font-name = normalFont;
          })
          // (utils.ifNotNull monospaceFont { } {
            monospace-font-name = monospaceFont;
          });
      };
    };
}
