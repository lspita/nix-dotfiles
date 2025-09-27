{
  config,
  lib,
  vars,
  ...
}:
with lib.custom;
modules.mkModule config ./font.nix {
  config =
    with vars.fonts;
    let
      normalFont = utils.fontString normal;
      monospaceFont = utils.fontString monospace;
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
