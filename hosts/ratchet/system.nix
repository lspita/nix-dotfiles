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
      login.gdm.enable = true;
      desktop.gnome.enable = true;
      virtualisation.enableDefaults = true;
    };
  };
}
