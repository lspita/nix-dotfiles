{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./blesh.nix {
  options = {
    fzfIntegration.enable = utils.mkTrueEnableOption "ble.sh fzf integration (if installed)";
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
          ''source -- "$(blesh-share)"/ble.sh --attach=none # attach does not work currently''
        ])
        (lib.mkAfter [
          ''[[ ! \$\{BLE_VERSION-} ]] || ble-attach''
        ])
      ];
    };
}
