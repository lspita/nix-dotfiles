{ ... }:
{
  custom = {
    core.enableDefaults = true;
    nixos = {
      wsl.enableDefaults = true;
      virtualisation.enableDefaults = true;
    };
  };
}
