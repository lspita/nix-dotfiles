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
    programs.bash.initExtra =
      # https://github.com/akinomyoga/ble.sh/wiki/Manual-A1-Installation#user-content-nixpkgs
      lib.mkAfter ''
        source -- "$(blesh-share)"/ble.sh --attach=none # attach does not work currently
        [[ ! \$\{BLE_VERSION-} ]] || ble-attach
      '';
  };
}
