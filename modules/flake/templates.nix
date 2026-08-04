let
  templatesRoot = ./_templates;
  templatePath = path: "${templatesRoot}/${path}";
in
{
  flake.templates = {
    nix = {
      description = "Nix devshell";
      path = templatePath "nix";
    };
  };
}
