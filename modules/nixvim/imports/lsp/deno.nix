{ ... }:

{
  programs.nixvim = {
    lsp = {
      servers = {
        denols = {
          enable = true;
        };
      };
    };
  };
}
