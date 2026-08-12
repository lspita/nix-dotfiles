{
  den.aspects.boot = {
    nixos.boot = {
      # https://wiki.nixos.org/wiki/Linux_kernel
      loader = {
        timeout = null;
        efi.canTouchEfiVariables = true;
      };
      tmp.cleanOnBoot = true;
    };
  };
}
