{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./vscode.nix {
  config = {
    programs.vscode.enable = true;
  };
}
