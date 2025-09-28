{ root, lib }:
config: path: module:
let
  imports = module.imports or [ ];
  options = module.options or { };
  enable = module.enable or "enable";
  flakePathList = (
    lib.lists.drop 4 # "/nix/store/<hash>/..." is splitted into ["" "nix" "store" "<hash>" ...]
      (with lib.strings; splitString "/" (removeSuffix ".nix" (builtins.toString path)))
  );
  pathList = [ "custom" ] ++ flakePathList;
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
      cfg (
        let
          relativeListPath =
            subpath:
            lib.lists.foldl' (
              pathList: p:
              if p == "." then
                pathList
              else if p == ".." then
                lib.lists.dropEnd 1 pathList
              else
                pathList ++ [ p ]
            ) pathList subpath;
        in
        rec {
          inherit self;
          path = lib.strings.concatStringsSep "/" flakePathList;
          setSubconfig = subpath: value: lib.attrsets.setAttrByPath (relativeListPath subpath) value;
          getSubconfig = subpath: lib.attrsets.getAttrFromPath (relativeListPath subpath) config;
          setDefaultModules = value: setSubconfig [ ] (root.utils.mkDefaultRec value);
        }
      )
    else
      cfg
  );
}
