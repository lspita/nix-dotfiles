{ ... }:
{
  custom = {
    core.enableDefaults = true;
    services.enableDefaults = true;
    nixos = {
      wsl.enable = true;
      virtualisation.enableDefaults = true;
    };
  };
}
