{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./environment.nix {
  config = {
    home.sessionVariables =
      with vars.defaultApps;
      (optionals.ifNotNull { } {
        EDITOR = terminalEditor;
        VISUAL = terminalEditor;
      } terminalEditor)
      // (optionals.ifNotNull { } {
        BROWSER = browser.program;
      } browser);
  };
}
