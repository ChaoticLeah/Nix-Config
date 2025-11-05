{ ... }:

{
  programs.nixvim = {
    lsp = {
      servers = {
        markdown_oxide = {
          enable = true;
        };
      };
    };
  };
}

