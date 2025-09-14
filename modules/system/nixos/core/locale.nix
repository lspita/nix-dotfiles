{
  config,
  lib,
  vars,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "nixos"
    "core"
    "locale"
  ];
  mkConfig =
    { ... }:
    with vars.linux.locale;
    {
      time.timeZone = timeZone;
      i18n = {
        defaultLocale = default;
        extraLocaleSettings = extraSettings;
      };
      console.keyMap = keyboard;
    };
}
