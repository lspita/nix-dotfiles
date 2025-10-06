{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./. {
  options = {
    fzfIntegration.enable = utils.mkTrueEnableOption "ble.sh fzf integration (if installed)";
  };
  config =
    { self, ... }:
    {
      home = {
        packages = with pkgs; [ blesh ];
        file.".blerc".source = ./.blerc;
      };
      # https://github.com/akinomyoga/ble.sh/wiki/Manual-A1-Installation#user-content-nixpkgs
      custom.shell.rc = lib.mkMerge [
        (lib.mkBefore [
          ''source -- "$(blesh-share)"/ble.sh''
        ])
        (lib.mkAfter [
          ''[[ ! \$\{BLE_VERSION-} ]] || ble-attach''
        ])
      ];
    };
}
