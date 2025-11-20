{ pkgs, ... }:

{
  #programs.nixvim = {
  #
  #  plugins.indent-blankline.enable = false; # Disable if you don't want both
  #
  #  extraPlugins = [
  #    (pkgs.vimUtils.buildVimPlugin {
  #      name = "indent-rainbowline";
  #      src = pkgs.fetchFromGitHub {
  #        owner = "TheGLander";
  #        repo = "indent-rainbowline.nvim";
  #        rev = "master"; # Or use a specific commit hash
  #        sha256 = "sha256-dSXNtbyPY5ZWT/RCYsmy/swgErJm7zSfaDd5J+15wYc=
  #"; # You'll need the correct hash
  #       };
  #    })
  # ];

  #extraConfigLua = ''
  # require("indent-rainbowline").setup({
  #  -- Configuration options
  # })
  #'';
  #};
}
