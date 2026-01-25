{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    lib.attrsets.recursiveUpdate
      (setDefaultSubconfig {
        sshAgentBridge.enable = true;
        open.enable = true;
      })
      {
        custom.shell.rc = lib.mkBefore [
          # used in other wsl functions, needs to be sourced before
          ''
            __win-command-exists() {
              powershell.exe -Command "if (Get-Command '$1' -ErrorAction SilentlyContinue) { exit 0 } else { exit 1 }"
            }
          ''
        ];
        home.shellAliases = {
          wsl-terminate = "wsl.exe -t $WSL_DISTRO_NAME";
          clean-zone-identifiers = "find . -name '*Zone.Identifier' -print -exec rm -rf '{}' \\; 2>/dev/null";
        };
      };
}
