{ ... }:
{
  custom = {
    core.enableDefaults = true;
    services.enableDefaults = true;
    development.enableDefaults = true;
    nixos = {
      core.enableDefaults = true;
      services.enableDefaults = true;
      virtualisation.enableDefaults = true;
    };
  };
}
