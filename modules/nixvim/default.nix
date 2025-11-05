{ config, pkgs, lib, ...}:
let
  plugins = import ./plugins.nix { inherit config; inherit pkgs; inherit lib;};
  keymaps = import ./keymaps.nix { inherit config; };
  extraVim = builtins.readFile ./extra.vim;
in
{
  imports = lib.filter
    (n: 
      (lib.strings.hasSuffix ".nix" n) 
#      && (!(builtins.elem (baseNameOf n) excludedFiles))
    )
    (lib.filesystem.listFilesRecursive ./imports);

  programs.nixvim = {
    enable = true;
    plugins = plugins;
    keymaps = keymaps;
    
    extraPackages = [
      pkgs.ripgrep
      pkgs.fd
    ];

    colorschemes.poimandres = {
      enable = true;
    };

    clipboard.providers.wl-copy = {
      enable = true;
      package = pkgs.wl-clipboard;
    };

    globalOpts = {
      # Line numbers
      number = true;
      relativenumber = true;

      # Enable more colors (24-bit)
      termguicolors = true;

      # Tabwidth
      tabstop = 2;
      shiftwidth = 2;
    };


    globals = {
      mapleader = " ";
    };

    extraConfigVim = extraVim;
  };
}
