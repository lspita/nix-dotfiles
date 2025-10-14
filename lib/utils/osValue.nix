{ systemType }:
{
  linux,
  darwin,
  wsl ? linux,
}: # @options doesn't have the wsl value if not given
let
  options = { inherit linux darwin wsl; };
in
options.${systemType}
