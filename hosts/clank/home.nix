{ ... }:
{
  custom = {
    core.enableDefaults = true;
    linux = {
      core.enableDefaults = true;
      desktop.plasma.enableDefaults = true;
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
