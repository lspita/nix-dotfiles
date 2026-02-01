{
  description = "I may be autistic";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # https://nix-community.github.io/NixOS-WSL/how-to/nix-flakes.html
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

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

    # https://github.com/nix-community/NUR
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://nix-community.github.io/haumea/intro/getting-started.html
    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/numtide/flake-utils
    flake-utils.url = "github:numtide/flake-utils";

    # https://github.com/nix-community/plasma-manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    inputs:
    import ./outputs (
      inputs
      // rec {
        flakeRoot = ./.;
        flakePath = filePath: "${flakeRoot}/${filePath}";
      }
    );
}
