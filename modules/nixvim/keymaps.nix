{ ... }:
[
  # navigation -------------------------
  {
    mode = "n";
    key = "<C-k>";
    action = ":wincmd k<CR>";
    options = {
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<C-j>";
    action = ":wincmd j<CR>";
    options = {
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<C-h>";
    action = ":wincmd h<CR>";
    options = {
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<C-l>";
    action = ":wincmd l<CR>";
    options = {
      silent = true;
    };
  }

  #Telescope --------------------------------
  {
    action = "<cmd>Telescope find_files<CR>";
    key = "<leader>ff";
    mode = "n";
    options = { noremap = true; silent = true; };
  }
  {
    action = "<cmd>Telescope live_grep<CR>";
    key = "<leader>fg";
    mode = "n";
    options = { noremap = true; silent = true; };
  }
  {
    action = "<cmd>Telescope buffers<CR>";
    key = "<leader>fb";
    mode = "n";
    options = { noremap = true; silent = true; };
  }
  {
    action = "<cmd>Telescope oldfiles<CR>";
    key = "<leader>fr";
    mode = "n";
    options = { noremap = true; silent = true; };
  }
  # Documentation & help
  {
    action = "<cmd>Telescope man_pages<CR>";
    key = "<leader>dm";
    mode = "n";
    options = { noremap = true; silent = true; };
  }
  # UI & appearance
  {
    action = "<cmd>Telescope colorscheme<CR>";
    key = "<leader>tc";
    mode = "n";
    options = { noremap = true; silent = true; };
  }

  # NeoTree -----------------------
  {
    mode = "n";
    key = "<C-b>";
    action = "<cmd>Neotree focus<CR>";
    options = {
      silent = true;
    };
  }
  {
    mode = "n";
    key = "♠"; # <C-S-b> but configured in the terminal
    action = "<cmd>Neotree toggle<CR>";
    options = {
      silent = true;
      remap = true;
    };
  }
  # LazyGit --------------------------------
  {
    action = "<cmd>LazyGit<CR>";
    key = "<leader>gs";
    mode = "n";
    options = { noremap = true; silent = true; };
  }
  # Undotree -----------------------------
  { 
    mode = "n";
    key = "<C-u>";
    action = "<cmd>UndotreeToggle<CR>";
    options = {
      silent = true;
      remap = true;
    };
  }
  # OIL    -----------------------------
  {
    mode = "n";
    action = ":Oil<CR>";
    key = "-";
  }
  # Harpoon    -----------------------------
  {
    mode = "n";
    action = ''
        lua require("harpoon"):list():add()
      '';
    key = "<leader>a";
  }
  {
    mode = "n";
    action = ''
        lua require("harpoon.ui").toggle_quick_menu(require("harpoon"):list())
      '';
    key = "<leader>l";
  }
  # open errors -----------------------------
  {
    mode = "n";
    key = "<leader>e";
    action = {
      __raw = "function() vim.diagnostic.open_float(nil, { focus = false }) end";
    };
  }

  {
    mode = "n";
    key = "<leader>f";
    action = ''
      <cmd>lua require("conform").format({ async = true, lsp_fallback = true })<CR>
    '';
    options.desc = "Format file with Conform";
  }
]

