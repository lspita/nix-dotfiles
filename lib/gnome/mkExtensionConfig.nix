{ lib }:
{
  package,
  uuid ? package.extensionUuid,
  name ? package.extensionPortalSlug,
  settings ? { },
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
