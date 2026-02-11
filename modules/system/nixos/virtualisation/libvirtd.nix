{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./libvirtd.nix {
  config = {
    virtualisation.libvirtd.enable = true;
    users.users.${vars.user.username}.extraGroups = [ "libvirtd" ];
  };
}
