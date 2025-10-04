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
