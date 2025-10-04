{
  config,
  lib,
  vars,
  flakeInputs,
  ...
}:
with lib.custom;
modules.mkDefaultsModule config ./. {
  imports = [
    flakeInputs.nixos-wsl.nixosModules.default
  ];

  config = {
    wsl.enable = true;
    wsl.defaultUser = vars.user.username;
    programs.nix-ld.enable = true;
    # disable conflicts
    custom.nixos.core = {
      enableDefaults = false;
      ssh.enable = true;
    };
  };
}
