{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./settings.nix {
  config = {
    programs.plasma = {
      # overrideConfig = true;
      workspace.enableMiddleClickPaste = false; # it doesn't disable it in reality :(
      input.keyboard.layouts = [ { layout = vars.linux.locale.keyboard; } ];
      session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
      configFile = {
        kded5rc.Module-browserintegrationreminder.autoload = false; # disable browser integration alert in system tray
        kwinrc.Effect-overview.FilterWindows = false; # make search in overview ignore windows
      };
    };
  };
}
