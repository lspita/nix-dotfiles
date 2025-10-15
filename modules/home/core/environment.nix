{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./environment.nix {
  config = {
    home.sessionVariables =
      with vars.linux.defaultApps;
      (utils.ifNotNull editor.program { } {
        EDITOR = editor.program;
        VISUAL = editor.program;
      })
      // (utils.ifNotNull browser.program { } {
        BROWSER = browser.program;
      });
  };
}
