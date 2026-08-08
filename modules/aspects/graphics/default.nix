{ inputs, ... }: {
  imports = [ (inputs.den.namespace "graphics" false) ];
}
