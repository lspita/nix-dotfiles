vars: {
  linux.defaultApps = with vars.linux.defaultApps; {
    terminal = {
      desktop = "org.gnome.Console.desktop";
      program = "kgx";
    };
    pdf = browser.desktop;
    mail = browser.desktop;
    image = "org.gnome.Loupe.desktop"; # chrome overrides it
  };
}
