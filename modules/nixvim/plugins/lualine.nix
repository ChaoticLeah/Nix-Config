{ ... }:

{
  lualine = {
    enable = true;
    settings = {
      options = {
        disabled_filetypes = {
          __unkeyed-1 = "neo-tree";
        };
      };
      
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [
          "filename"
          "diff"
        ];

        lualine_x = [
          "diagnostics"

          # Show current LSP client
          {
            __unkeyed-1 = {
              __raw = ''
                function()
                  local msg = ""
                  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                  local clients = vim.lsp.get_clients()
                  if next(clients) == nil then
                      return msg
                  end
                  for _, client in ipairs(clients) do
                      local filetypes = client.config.filetypes
                      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                          return client.name
                      end
                  end
                  return msg
                end
              '';
            };
            icon = "";
            color = { fg = "#ffffff"; };
          }

          # Git blame
          {
            __unkeyed-1 = {
              __raw = ''
                function()
                  local ok, blame_info = pcall(require, "gitsigns")
                  if not ok or not blame_info then
                    return ""
                  end
                  local text = blame_info.get_blame_text()
                  if text and text ~= "" then
                    return " " .. text
                  else
                    -- fallback to async blame API (available in newer gitsigns)
                    local blame = blame_info.blame_line({ full = true })
                    if type(blame) == "table" and blame.author then
                      return string.format(" %s • %s", blame.author, blame.summary or "")
                    end
                    return ""
                  end
                end
              '';
            };
            color = { fg = "#b0b0b0"; };
          }

          "encoding"
          "fileformat"
          "filetype"
        ];

        lualine_y = [ "progress" ];
        lualine_z = [ "location" ];
      };
    };
  };
}

