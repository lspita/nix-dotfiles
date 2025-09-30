{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./blesh.nix {
  config = {
    home.packages = with pkgs; [ blesh ];
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
