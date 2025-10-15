{ root, lib }:
{ config, configType, ... }:
path: module:
let
  imports = module.imports or [ ];
  options = module.options or { };
  enableOption = module.enableOption or "enable";
  enable = module.enable or false;
  rootPathList = [ "custom" ] ++ (module.root or [ ]);
  moduleDirPath =
    (
      let
        dirPath = module.dirPath or [ ];
      in
      if builtins.isList dirPath then dirPath else splitPath dirPath
    )
    ++ [
      "modules"
      configType
    ];
  splitPath = lib.strings.splitString "/";

  modulePathList = (
    lib.lists.drop 4 # "/nix/store/<hash>/..." is splitted into [ "" "nix" "store" "<hash>" ... ]
      (splitPath (lib.strings.removeSuffix ".nix" (builtins.toString path)))
  );
  pathList = rootPathList ++ (lib.lists.removePrefix moduleDirPath modulePathList);
  getSubconfig = path: lib.attrsets.getAttrFromPath path config;
  self = getSubconfig pathList;
  super = getSubconfig (lib.lists.dropEnd 1 pathList);
  root = getSubconfig rootPathList;
  cfg = module.config;
in
{
  inherit imports;
  options = lib.attrsets.setAttrByPath pathList (
    {
      ${enableOption} = lib.mkOption {
        type = lib.types.bool;
        default = enable;
        description = "Whether to enable ${lib.concatStringsSep "." pathList}";
      };
    }
    // options
  );
  config = lib.mkIf (self.${enableOption}) (
    if builtins.isFunction cfg then
      cfg (rec {
        inherit
          pathList
          self
          super
          root
          ;
        path = lib.strings.concatStringsSep "/" modulePathList;
        setSubconfig = value: lib.attrsets.setAttrByPath pathList value;
      })
    else
      cfg
  );
}
