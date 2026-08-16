{
  den.aspects.kernel =
    let
      mkKernelAspect = kernelPkgsFn: {
        nixos = { pkgs, ... }: {
          boot.kernelPackages = kernelPkgsFn pkgs;
        };
      };
    in
    {
      stable = mkKernelAspect (pkgs: pkgs.linuxPackages);
      latest = mkKernelAspect (pkgs: pkgs.linuxPackages_latest);
    };
}
