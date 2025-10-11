{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./open.nix {
  config = {
    custom = {
      linux.core.xdg.openAlias = false;
      shell.rc = [
        ''
          open() {
            local args=()
            for arg in "$@"; do
                args+=("\"$arg\"")
            done
            powershell.exe -Command "Start-Process ''${args[*]}"
          }
          BROWSER=open
        ''
      ];
    };
    home.shellAliases = {
      xdg-open = "open";
    };
  };
}
