{ den, lib, ... }: {
  den.aspects.programs.wl-clipboard.nixos =
    { host, pkgs, ... }:
    lib.optionalAttrs (host.hasAspect den.aspects.system.wayland) {
      environment.systemPackages = with pkgs; [ wl-clipboard ];
    };
}
