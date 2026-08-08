{ inputs, ... }: {
  imports = [ (inputs.den.namespace "nix" false) ];
}
