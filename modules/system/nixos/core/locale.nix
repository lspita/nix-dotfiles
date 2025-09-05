{
  config,
  customLib,
  vars,
  ...
}:
customLib.mkModule {
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
      # Set your time zone.
      time.timeZone = timeZone;

      # Select internationalisation properties.
      i18n.defaultLocale = default;

      i18n.extraLocaleSettings = extraSettings;

      # Configure console keymap
      console.keyMap = keyboard;
    };
}
