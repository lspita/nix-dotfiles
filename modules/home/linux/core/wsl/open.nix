{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./open.nix {
  config = {
    custom = {
      linux.core.xdg.openAlias = lib.mkForce false;
      shell.rc = lib.mkBefore [
        ''
          open() {
            local args=()
            for arg in "$@"; do
                args+=("\"$arg\"")
            done
            powershell.exe -Command "Start-Process ''${args[*]}"
          }
        ''
      ];
    };
    home = {
      shellAliases = {
        xdg-open = "open";
      };
      sessionVariables = {
        BROWSER = lib.mkForce "open";
      };
    };
  };
}
