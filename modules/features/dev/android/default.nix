{
  den.aspects.dev.android.nixos =
    { user, ... }:
    {
      # https://wiki.nixos.org/wiki/Android
      users.users.${user.userName}.extraGroups = [ "kvm" ];
    };
}
