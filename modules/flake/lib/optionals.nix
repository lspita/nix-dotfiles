{
  flake.lib.optionals = {
    fmapNull = f: val: if isNull val then null else f val;
  };
}
