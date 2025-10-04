{ systemType }:
{
  linux,
  darwin,
  wsl ? linux,
}@options:
options.${systemType}
