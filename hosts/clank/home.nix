{
  ...
}:
{
  modules = {
    core.enable = true;
    security = {
      bitwarden = {
        enable = true;
        sshAgent.enable = true;
      };
    };
    # manage your shell with home manager to enable home.sessionVariables
    # https://discourse.nixos.org/t/home-manager-doesnt-seem-to-recognize-sessionvariables/8488/6
    shell = {
      bash.enable = true;
    };
  };
}
