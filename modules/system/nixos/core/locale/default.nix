{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    with vars.linux.locale;
    lib.mkMerge [
      (setDefaultSubconfig {
        hunspell.enable = true;
      })
      {
        time.timeZone = timeZone;
        i18n = {
          defaultLocale = default;
          extraLocaleSettings = optionals.getNotNull { } extraSettings;
        };
        console.keyMap = keyboard;
      }
    ];
}
