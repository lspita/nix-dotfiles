{
  config,
  lib,
  vars,
  flakeInputs,
  ...
}:
with lib.custom;
modules.mkModule config ./wsl.nix {
  imports = [
    flakeInputs.nixos-wsl.nixosModules.default
  ];

  config = {
    wsl = {
      enable = true;
      defaultUser = vars.user.username;
    };
    programs.nix-ld.enable = true;
    custom.nixos.core.enableDefaults = false;
  };
}
