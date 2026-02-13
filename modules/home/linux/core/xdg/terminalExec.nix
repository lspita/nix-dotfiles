{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./terminalExec.nix {
  config = with vars.defaultApps; {
    xdg.terminal-exec = {
      enable = true;
    }
    // (optionals.ifNotNull { } {
      settings.default = [ terminal.desktop ];
    } terminal);
  };
}
