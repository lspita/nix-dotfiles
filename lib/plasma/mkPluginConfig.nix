{ lib }:
# set: config for kde plasma kwin plugin
{
  package, # pkg: plugin package
  name ? lib.getName package, # string?: plugin name
  settings ? { }, # set?: extension settings
}:
{
  home.packages = [ package ];
  programs.plasma.configFile.kwinrc = {
    Plugins."${name}Enabled" = true;
    "Script-${name}" = settings;
  };
}
