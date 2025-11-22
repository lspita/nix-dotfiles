{ lib }:
# set: config for gnome shell extension
{
  package, # pkg: extension package
  uuid ? package.extensionUuid, # string?: extension uuid
  name ? package.extensionPortalSlug, # string?: extension name
  settings ? { }, # set?: extension dconf settings
}:
{
  programs.gnome-shell.extensions = [ { inherit package; } ];
  dconf.settings = {
    "org/gnome/shell".enabled-extensions = [ uuid ];
  }
  // lib.attrsets.foldlAttrs (
    result: key: value:
    result
    // {
      ${
        lib.strings.concatStringsSep "/" (
          [
            "org/gnome/shell/extensions/${name}"
          ]
          ++ (if key != "" then [ key ] else [ ])
        )
      } =
        value;
    }
  ) { } settings;
}
