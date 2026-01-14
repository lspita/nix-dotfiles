{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./accessibility.nix {
  options = {
    onScreenKeyboard.enable = utils.mkEnableOption true "on screen keyboard";
  };
  config =
    { self, ... }:
    {
      dconf.settings = {
        "org/gnome/desktop/interface".toolkit-accessibility = true;
      }
      // (
        if self.onScreenKeyboard.enable then
          {
            "org/gnome/desktop/a11y/applications".screen-keyboard-enabled = true;
            "org/gnome/desktop/a11y/keyboard".enable = true;
          }
        else
          { }
      );
    };
}
