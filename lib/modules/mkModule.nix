{ root, lib }:
config: path: module:
let
  imports = module.imports or [ ];
  options = module.options or { };
  enable = module.enable or "enable";
  pathList = [
    "custom"
  ]
  ++ (lib.lists.drop 4 # "/nix/store/<hash>/..." is splitted into ["" "nix" "store" "<hash>" ...]
    (with lib.strings; splitString "/" (removeSuffix ".nix" (builtins.toString path)))
  );
  self = lib.attrsets.getAttrFromPath pathList config;
  cfg = module.config;
in
{
  inherit imports;
  options = lib.attrsets.setAttrByPath pathList (
    {
      ${enable} = lib.mkEnableOption (lib.concatStringsSep "." pathList);
    }
    // options
  );
  config = lib.mkIf (self.${enable}) (
    if builtins.isFunction cfg then
      cfg rec {
        inherit self;
        setSubconfig = subpath: value: lib.attrsets.setAttrByPath (pathList ++ subpath) value;
        setDefaultModules = value: setSubconfig [ ] (root.utils.mkDefaultRec value);
      }
    else
      cfg
  );
}
