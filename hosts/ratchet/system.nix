{ ... }:
{
  custom = {
    core.enableDefaults = true;
    services.enableDefaults = true;
    nixos = {
      core = {
        enableDefaults = true;
        boot.dualBoot.enable = true;
      };
      services.enableDefaults = true;
      login.sddm.enable = true;
      desktop.plasma.enable = true;
      virtualisation.enableDefaults = true;
    };
    development.enableDefaults = true;
  };
}
