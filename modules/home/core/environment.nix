{
  config,
  lib,
  vars,
  ...
}:
with lib.custom;
modules.mkModule config ./environment.nix {
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
