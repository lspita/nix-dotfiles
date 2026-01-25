{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./font.nix {
  config = with vars.fonts; {
    dconf.settings = {
      "org/gnome/desktop/interface" =
        let
          fontString = font: "${font.name} ${toString font.size}";
        in
        (optionals.ifNotNull { } ({
          font-name = fontString normal;
          document-font-name = fontString normal;
        }) normal)
        // (optionals.ifNotNull { } ({
          monospace-font-name = fontString monospace;
        }) monospace);
    };
  };
}
