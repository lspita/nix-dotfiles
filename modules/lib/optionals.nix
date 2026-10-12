{
  lib2.optionals = {
    fmapNull = f: val: if isNull val then null else f val;
    getOrDefault = default: val: if isNull val then default else val;
  };
}
