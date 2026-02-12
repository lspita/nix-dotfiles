{ ... }:
{
  custom = {
    core.enableDefaults = true;
    services.enableDefaults = true;
    development.enableDefaults = true;
    nixos = {
      core.enableDefaults = true;
      services.enableDefaults = true;
      login.sddm.enable = true;
      desktop.plasma.enable = true;
      virtualisation.enableDefaults = true;
    };
  };
}
