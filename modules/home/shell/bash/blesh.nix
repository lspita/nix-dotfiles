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
    custom.shell.rc = lib.mkAfter [
      # https://github.com/akinomyoga/ble.sh/wiki/Manual-A1-Installation#user-content-nixpkgs
      ''
        source -- "$(blesh-share)"/ble.sh --attach=none # attach does not work currently
        [[ ! \$\{BLE_VERSION-} ]] || ble-attach
      ''
    ];
  };
}
