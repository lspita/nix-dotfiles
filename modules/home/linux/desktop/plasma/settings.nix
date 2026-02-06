{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./settings.nix {
  options = {
    virtualDesktops.number = lib.mkOption {
      type = with lib.types; ints.unsigned;
      default = 5;
      description = "Number of virtual desktops";
    };
  };
  config =
    { self, ... }:
    {
      programs.plasma = {
        overrideConfig = false;
        workspace = {
          enableMiddleClickPaste = false;
          splashScreen.theme = "org.kde.breeze.desktop";
        };
        input.keyboard.layouts = [ { layout = vars.linux.locale.keyboard; } ];
        session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
        kwin = {
          inherit (self) virtualDesktops;
          cornerBarrier = false;
          edgeBarrier = 0;
          effects = {
            blur.enable = true;
            desktopSwitching.navigationWrapping = true;
            hideCursor = {
              enable = true;
              hideOnInactivity = 5;
              hideOnTyping = true;
            };
            shakeCursor.enable = true;
            translucency.enable = true;
          };
        };
        configFile = {
          kded5rc.Module-browserintegrationreminder.autoload = false; # disable browser integration alert in system tray
          kwinrc.Effect-overview.FilterWindows = false; # make search in overview ignore windows;
          kdeglobals.General =
            with vars.linux.defaultApps;
            let
              plasmaDefaultTerminal = plasma.defaults.apps.terminal;
              customTerminal = optionals.getNotNull plasmaDefaultTerminal terminal;
            in
            {
              TerminalApplication.value = customTerminal.program;
              TerminalService.value = customTerminal.desktop;
            };
        };
      };
    };
}
