{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./environment.nix {
  config = {
    home.sessionVariables =
      with vars.linux.defaultApps;
      (utils.ifNotNull { } {
        EDITOR = editor.program;
        VISUAL = editor.program;
      } editor.program)
      // (utils.ifNotNull { } {
        BROWSER = browser.program;
      } browser.program);
  };
}
