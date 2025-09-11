{
  config,
  customLib,
  vars,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "plasma"
    "settings"
  ];
  mkConfig =
    { ... }:
    {
      programs.plasma = {
        overrideConfig = true;
        workspace.enableMiddleClickPaste = false; # it doesn't disable it in reality :(
        input.keyboard.layouts = [ { layout = vars.linux.locale.keyboard; } ];
        session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
        configFile.kded5rc.Module-browserintegrationreminder.autoload = false; # disable browser integration alert in system tray
        configFile.kwinrc.Effect-overview.FilterWindows = false; # make search in overview ignore windows
      };
    };
}
