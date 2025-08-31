{ flakeInputs }:
(_: prev: {
  bitwarden-desktop =
    flakeInputs.bitwarden-desktop-proxy-fix.legacyPackages.${prev.system}.bitwarden-desktop;
})
