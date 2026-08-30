{ inputs, ... }: {
  imports = with inputs.den.flakeModules; [ default ];
}
