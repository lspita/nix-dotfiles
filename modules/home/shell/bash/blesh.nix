{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./blesh.nix {
  options = {
    fzfIntegration.enable = modules.mkEnableOption true "ble.sh fzf integration (if installed)";
  };
  config =
    { self, ... }:
    {
      home = {
        packages = with pkgs; [ blesh ];
        file.".blerc".text =
          if self.fzfIntegration.enable then
            ''
              # https://github.com/akinomyoga/blesh-contrib/blob/master/integration/fzf.md

              # Set up fzf
              ble-import -d integration/fzf-completion
              ble-import -d integration/fzf-key-bindings
            ''
          else
            "";
      };
      # https://github.com/akinomyoga/ble.sh/wiki/Manual-A1-Installation#user-content-nixpkgs
      custom.shell.rc = lib.mkMerge [
        (lib.mkBefore [
          ''source -- "$(blesh-share)"/ble.sh --attach=none''
        ])
        (lib.mkAfter [
          ''[[ ! \$\{BLE_VERSION-} ]] || ble-attach''
        ])
      ];
    };
}
