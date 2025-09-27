{
  config,
  lib,
  vars,
  ...
}:
with lib.custom;
modules.mkModule config ./locale.nix {
  config = with vars.linux.locale; {
    time.timeZone = timeZone;
    i18n = {
      defaultLocale = default;
      extraLocaleSettings = extraSettings;
    };
    console.keyMap = keyboard;
  };
}
