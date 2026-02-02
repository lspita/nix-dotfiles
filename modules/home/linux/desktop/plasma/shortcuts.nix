{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./shortcuts.nix {
  config = {
    custom.linux.desktop.plasma.appearance.koi.toggle.shortcut = "Meta+F5";
    programs.plasma.shortcuts = {
      kwin = {
        Overview = "Meta";
        "Window Close" = "Meta+Q";
        "MoveMouseToFocus" = "None"; # Meta+F5
        "MoveMouseToCenter" = "None"; # Meta+F6
      };
      plasmashell = {
        "activate application launcher" = "None"; # Meta
        "manage activities" = "Meta+W"; # Meta+Q
      };
    }
    // (
      let
        plasmaDefaultTerminal = plasma.defaults.apps.terminal;
        customTerminal = optionals.getNotNull plasmaDefaultTerminal vars.linux.defaultApps.terminal;
      in
      {
        "services/${plasmaDefaultTerminal.desktop}" = {
          "_launch" = "None"; # Ctrl+Alt+T
        };
      }
      // {
        # override plasma default terminal if null
        "services/${customTerminal.desktop}" = {
          "_launch" = "Meta+Return";
        };
      }
    );
  };
}
