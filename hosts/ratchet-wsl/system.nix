{ ... }:
{
  custom = {
    core.enableDefaults = true;
    services.enableDefaults = true;
    nixos = {
      wsl.enableDefaults = true;
      virtualisation.enableDefaults = true;
    };
  };
}
