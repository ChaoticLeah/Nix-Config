{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins.hover-nvim
    ];
  };
}
