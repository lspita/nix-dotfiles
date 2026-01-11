{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./environment.nix {
  config = {
    home.sessionVariables =
      with vars.linux.defaultApps;
      (utils.ifNotNull { } {
        EDITOR = terminalEditor;
        VISUAL = terminalEditor;
      } terminalEditor)
      // (utils.ifNotNull { } {
        BROWSER = browser.program;
      } browser);
  };
}
