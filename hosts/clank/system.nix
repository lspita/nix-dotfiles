{ ... }:
{
  custom = {
    core.enableDefaults = true;
    services.enableDefaults = true;
    nixos = {
      core.enableDefaults = true;
      services.enableDefaults = true;
      intel.graphics.enable = true;
      login.gdm.enable = true;
      desktop.gnome.enable = true;
      virtualisation.enableDefaults = true;
    };
  };
}
