{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./locale.nix {
  config = with vars.linux.locale; {
    time.timeZone = timeZone;
    i18n = {
      defaultLocale = default;
      extraLocaleSettings = utils.getNotNull { } extraSettings;
    };
    console.keyMap = keyboard;
  };
}
