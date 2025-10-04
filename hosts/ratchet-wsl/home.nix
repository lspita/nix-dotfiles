{ ... }:
{
  custom = {
    core.enableDefaults = true;
    linux = {
      core.enableDefaults = true;
      wsl.enableDefaults = true;
    };
    shell.enableDefaults = true;
    tools.enableDefaults = true;
  };
}
