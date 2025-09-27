{
  config,
  lib,
  vars,
  ...
}:
with lib.custom;
modules.mkModule config ./environment.nix {
  config = {
    home.sessionVariables = with vars.linux.defaultApps; {
      EDITOR = editor.program;
      VISUAL = editor.program;
      BROWSER = browser.program;
    };
  };
}
