{ root, lib }:
# https://github.com/NixOS/nixpkgs/blob/c23193b943c6c689d70ee98ce3128239ed9e32d1/pkgs/desktops/gnome/extensions/buildGnomeExtension.nix#L68-L71
{
  config,
  package,
  name ? package.extensionPortalSlug,
  uuid ? package.extensionUuid,
  path ? [
    "linux"
    "desktop"
    "gnome"
    "extensions"
    name
  ],
  imports ? [ ],
  extraOptions ? { },
  mkConfig ? null,
}:
root.mkModule {
  inherit
    config
    path
    name
    extraOptions
    ;
  imports = imports;
  mkConfig =
    { cfg }:
    {
      programs.gnome-shell.extensions = [ { inherit package; } ];
      dconf.settings = {
        "org/gnome/shell".enabled-extensions = [ uuid ];
      }
      // (
        if builtins.isNull mkConfig then
          { }
        else
          lib.attrsets.foldlAttrs (
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
          ) { } (mkConfig cfg)
      );
    };
}
