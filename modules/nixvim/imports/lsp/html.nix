{ ... }:

{
  programs.nixvim = {
    lsp = {
      servers = {
        html = {
          enable = true;
          config.filetypes = [
            "cf"
            "html"
            "templ"
          ];
        };
      };
    };
  };
}

