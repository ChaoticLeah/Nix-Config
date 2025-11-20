{ ... }:

{
  programs.nixvim = {
    lsp = {
      servers = {
        ccls = {
          enable = true;
        };
      };
    };
  };
}
