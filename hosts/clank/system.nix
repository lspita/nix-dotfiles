{ ... }:
{
  custom = {
    core.enableDefaults = true;
    services.enableDefaults = true;
    nixos = {
      core.enableDefaults = true;
      intel.graphics.enable = true;
      login.gdm.enable = true;
      desktop = {
        enableDefaults = true;
        gnome = {
          enable = true;
          nautilus.enableDefaults = true;
        };
        cosmic.enable = true;
      };
      virtualisation.enableDefaults = true;
    };
  };
}
