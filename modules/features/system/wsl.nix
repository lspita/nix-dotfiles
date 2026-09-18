{
  den.aspects.system.wsl = {
    wsl.enable = true;
    nixos.environment.sessionVariables.LD_LIBRARY_PATH = [
      "/usr/lib/wsl/lib"
    ];
  };
}
