{ ... }:
{
  conform-nvim = {
    enable = true;
    settings = {
      #TODO Need to put something here but not sure what
      formatters_by_ft = {
        lua = [ "stylua" ];
        javascript = [ "prettier" ];
        typescript = [ "prettier" ];
        nix = [ "nixfmt" ];
      };
    };
  };
}

