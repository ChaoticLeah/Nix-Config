{ ... }:

{
  programs.nixvim = {
    lsp = {
      servers = {
        jsonls = {
          enable = true;
        };
      };
    };
  };
}
