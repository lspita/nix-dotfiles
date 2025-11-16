{
  lib,
  vars,
  flakeInputs,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./wsl.nix {
  imports = [
    flakeInputs.nixos-wsl.nixosModules.default
  ];

  config = {
    wsl = {
      enable = true;
      defaultUser = vars.user.username;
    };
    programs.nix-ld.enable = true;
    custom.nixos.core = {
      enableDefaults = false;
      nix-ld.enable = true;
    };
    environment.sessionVariables = {
      LD_LIBRARY_PATH = [
        "/usr/lib/wsl/lib"
      ];
    };
  };
}
