{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  custom.modules = {
    nixos = {
      core.enableDefaults = true;
      login.sddm.enable = true;
      desktop.plasma.enable = true;
    };
  };
}
