{ inputs, ... }: {
  imports = [ (inputs.den.namespace "boot" false) ];
}
