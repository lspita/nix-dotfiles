{
  ...
}:
{
  modules = {
    core.enableDefaults = true;
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
