{ ... }:
{
  custom.modules = {
    core.enableDefaults = true;
    linux.desktop = {
      core.enableDefaults = true;
      gnome = {
        enableDefaults = true;
        settings = {
          vrr.enable = true;
          fractionalScaling.enable = true;
          locationServices.enable = true;
        };
      };
    };
    security.bitwarden = {
      enable = true;
      sshAgent.enable = true;
    };
    shell = {
      enableDefaults = true;
      bash.enable = true;
    };
    terminal.gnome-console.enable = true;
    editor.zed.enable = true;
    browser.firefox = {
      enable = true;
      passwordManager.enable = false;
    };
    spotify.enable = true;
  };
}
