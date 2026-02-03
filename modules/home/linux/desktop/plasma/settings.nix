{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./settings.nix {
  config = {
    programs.plasma = {
      # overrideConfig = true;
      workspace.enableMiddleClickPaste = false; # it doesn't disable it in reality :(
      input.keyboard.layouts = [ { layout = vars.linux.locale.keyboard; } ];
      session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
      kwin = {
        cornerBarrier = false;
        edgeBarrier = 0;
      };
      configFile = {
        kded5rc.Module-browserintegrationreminder.autoload = false; # disable browser integration alert in system tray
        kwinrc = {
          Effect-overview.FilterWindows = false; # make search in overview ignore windows
          ElectricBorders = {
            Bottom.value = "None";
            BottomLeft.value = "None";
            BottomRight.value = "None";
            Left.value = "None";
            Right.value = "None";
            Top.value = "None";
            TopLeft.value = "None";
            TopRight.value = "None";
          };
        };
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
