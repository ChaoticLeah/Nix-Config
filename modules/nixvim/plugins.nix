{
  config,
  lib,
  pkgs,
  ...
}:

let
  pluginsDir = ./plugins;
  files = builtins.attrNames (builtins.readDir pluginsDir);
  nixFiles = builtins.filter (f: builtins.match ".*\\.nix" f != null && f != "default.nix") files;
  baseSets = map (
    file:
    import (pluginsDir + "/${file}") {
      inherit config;
      inherit pkgs;
      inherit lib;
    }
  ) nixFiles;
  basePlugins = builtins.foldl' (acc: s: acc // s) { } baseSets;
in
basePlugins
// {
  treesitter = {
    enable = true;
  };
  nix = {
    enable = true;
  };
  gitsigns = {
    enable = true;
  };
  autoclose = {
    enable = true;
  };
  presence = {
    enable = true;
  };
  undotree = {
    enable = true;

    settings = {
      SplitWidth = 30;
      WindowLayout = 3;
    };
  };
}
