{
  description = "I may be autistic";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # https://github.com/nix-darwin/nix-darwin
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://flake.parts/getting-started.html
    flake-parts.url = "github:hercules-ci/flake-parts";

    # https://den.denful.dev/tutorials/minimal/
    import-tree.url = "github:denful/import-tree";
    den.url = "github:denful/den";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { inputs, ... }: {
        _module.args = rec {
          inputs = inputs;
          flakeRoot = ./.;
          flakePath = filePath: "${flakeRoot}/${filePath}";
        };
        systems = inputs.nixpkgs.lib.systems.flakeExposed;
        imports = [
          (inputs.import-tree ./modules)
        ];
      }
    );
}
