{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./font.nix {
  config = with vars.fonts; {
    dconf.settings = {
      "org/gnome/desktop/interface" =
        (utils.ifNotNull { } (
          let
            fontString = utils.fontString normal;
          in
          {
            font-name = fontString;
            document-font-name = fontString;
          }
        ) normal)
        // (utils.ifNotNull { } (
          let
            fontString = utils.fontString monospace;
          in
          {
            monospace-font-name = fontString;
          }
        ) monospace);
    };
  };
}
