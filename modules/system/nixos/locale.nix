{
  config,
  customLib,
  vars,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "modules"
    "system"
    "nixos"
    "locale"
  ];
  mkConfig =
    { ... }:
    let
      lvars = vars.locale;
    in
    {
      # Set your time zone.
      time.timeZone = lvars.timeZone;

      # Select internationalisation properties.
      i18n.defaultLocale = lvars.default;

      i18n.extraLocaleSettings = lvars.extraSettings;

      # Configure console keymap
      console.keyMap = lvars.keyboard;
    };
}
