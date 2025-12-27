{ root, lib }:
# set: configuration module
{ config, configType, ... }: # set: config inputs
modulePath: # path: path to module (or dir if it is default.nix)
module:
/*
  {
    imports = list[imports]?: module imports
    options = set?: module options
    enableOption = string?: name of the option to enable the module
    enable = bool?: default enable value
    root = list[string]?: module subroot pathlist
    dirPath = string?: relative path to `modules` dir
    config = set | fn({
      pathList = list[string]: pathlist to module config
      self = set: module config
      super = set: parent module config
      root = set: root module config
      path = string: relative path to module file
      setSubconfig = fn(any) -> set: function to set submodules settings
    }) -> set: module config
  }
*/
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
      (splitPath (lib.strings.removeSuffix ".nix" (toString modulePath)))
  );
  pathList = rootPathList ++ (lib.lists.removePrefix moduleDirPath modulePathList);
  getSubconfig = configArrayPath: lib.attrsets.getAttrFromPath configArrayPath config;
  self = getSubconfig pathList;
  super = getSubconfig (lib.lists.dropEnd 1 pathList);
  rootPath = getSubconfig rootPathList;
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
      cfg (
        {
          inherit
            pathList
            self
            super
            ;
          root = rootPath;
          selfPath = lib.strings.concatStringsSep "/" modulePathList;

        }
        // rec {
          setSubconfig = value: lib.attrsets.setAttrByPath pathList value;
          setDefaultSubconfig = value: setSubconfig (root.utils.mkDefaultRec value);
        }
      )
    else
      cfg
  );
}
