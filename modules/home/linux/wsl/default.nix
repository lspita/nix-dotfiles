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
        custom.shell.rc = lib.mkMerge [
          (lib.mkBefore [
            # used in other wsl functions, needs to be sourced before
            ''
              __win-command-exists() {
                powershell.exe -Command "if (Get-Command '$1' -ErrorAction SilentlyContinue) { exit 0 } else { exit 1 }"
              }
            ''
          ])
          [
            ''
              clean-zone-identifier() {
                find . -type f -name "*Zone.Identifier" -exec rm "{}" \;
              }
            ''
          ]
        ];
        home.shellAliases = {
          wsl-terminate = "wsl.exe -t $WSL_DISTRO_NAME";
        };
      };
}
