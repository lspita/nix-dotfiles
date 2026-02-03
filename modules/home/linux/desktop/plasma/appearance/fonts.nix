{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./fonts.nix {
  config = {
    programs.plasma.fonts =
      let
        makeFont =
          font:
          optionals.ifNotNull null {
            family = font.name;
            pointSize = font.size * (font.scale or 1);
          } font;
      in
      with vars.fonts;
      {
        general = makeFont normal;
        fixedWidth = makeFont monospace;
        small = makeFont (normal // { scale = 0.8; });
        toolbar = makeFont normal;
        menu = makeFont normal;
        windowTitle = makeFont normal;
      };
  };
}
