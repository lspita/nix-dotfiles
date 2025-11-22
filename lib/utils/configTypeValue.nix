_:
# any: different value based on config type
{ configType, ... }: # set: config inputs
{
  system, # any: value if in system config
  home, # any: value if in home config
}@options:
options.${configType}
