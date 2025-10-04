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
          locationServices.enable = true;
        };
      };
    };
    shell.enableDefaults = true;
    tools.enableDefaults = true;
    apps.enableDefaults = true;
    terminal.gnome-console.enable = true;
    apps.browser.chrome.enable = true;
  };
}
