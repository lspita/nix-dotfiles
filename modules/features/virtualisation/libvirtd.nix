{
  den.aspects.virtualisation.libvirtd.nixos = { user, ... }: {
    virtualisation.libvirtd.enable = true;
    users.users.${user.userName}.extraGroups = [ "libvirtd" ];
  };
}
