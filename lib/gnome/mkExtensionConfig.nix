{ lib }:
{
  package,
  # https://github.com/NixOS/nixpkgs/blob/c23193b943c6c689d70ee98ce3128239ed9e32d1/pkgs/desktops/gnome/extensions/buildGnomeExtension.nix#L68-L71
  name ? package.extensionPortalSlug,
  uuid ? package.extensionUuid,
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
