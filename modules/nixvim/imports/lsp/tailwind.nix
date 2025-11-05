{ ... }:

{
  programs.nixvim = {
    lsp = {
      servers = {
        tailwindcss = {
          enable = true;
          config.filetypes = [
            "svelte"
            "html"
          ];
        };
      };
    };
  };
}

