{ ... }:
{
  modules = {
    core.enableDefaults = true;
    linux = {
      core.enableDefaults = true;
      desktop.plasmaSettings.enable = true;
    };
    pkgs.enable = true;
    security = {
      bitwarden = {
        enable = true;
        sshAgent.enable = true;
      };
    };
    shell = {
      enableDefaults = true;
      bash.enable = true;
    };
  };
}
