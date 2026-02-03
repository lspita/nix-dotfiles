{ ... }:
{
  custom = {
    core.enableDefaults = true;
    linux = {
      core.enableDefaults = true;
      desktop.gnome = {
        enableDefaults = true;
        settings = {
          vrr.enable = true;
          fractionalScaling.enable = true;
          locationServices.enable = true;
        };
      };
    };
    shell.enableDefaults = true;
    tools.enableDefaults = true;
    apps = {
      enableDefaults = true;
      chrome.enable = true;
    };
    terminal.gnome-console.enable = true;
  };
}
