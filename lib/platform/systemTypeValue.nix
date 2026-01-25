{ systemType }:
# any: different value based on system type
{
  linux, # any: value on linux systems
  darwin, # any: value on darwin systems (macos)
  wsl ? linux, # any?: value on wsl systems, same as `linux` if unset
}:
let
  # using @options doesn't have the wsl value if not given
  options = { inherit linux darwin wsl; };
in
options.${systemType}
