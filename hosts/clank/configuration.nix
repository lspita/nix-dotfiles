{
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  modules = {
    nixos = {
      core.enableDefaults = true;
      login = {
        sddm.enable = true;
      };
      desktop = {
        plasma.enable = true;
      };
    };
  };
}
