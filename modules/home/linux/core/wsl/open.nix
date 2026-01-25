{ config, lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./open.nix {
  config = {
    assertions = [
      {
        assertion = !config.custom.linux.core.xdg.mimeApps.openAlias.enable;
        message = "Cannot enable open function if xdg 'open' alias is enabled.";
      }
    ];
    custom.shell.rc = lib.mkBefore [
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
