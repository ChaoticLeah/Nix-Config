{ ... }:

{
  programs.nixvim = {
    lsp = {
      servers = {
        cssls = {
          enable = true;
        };
      };
    };
  };
}
