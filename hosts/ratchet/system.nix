{ ... }:
{
  custom = {
    core.enableDefaults = true;
    services.enableDefaults = true;
    nixos = {
      core.enableDefaults = true;
      services = {
        enableDefaults = true;
        openrgb.enable = true;
      };
      login.sddm.enable = true;
      desktop.plasma.enable = true;
      virtualisation.enableDefaults = true;
    };
  };
}
