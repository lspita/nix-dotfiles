{ ... }:
{
  custom = {
    core.enableDefaults = true;
    nixos = {
      core.enableDefaults = true;
      wsl.enable = true;
      virtualisation.enableDefaults = true;
    };
  };
}
