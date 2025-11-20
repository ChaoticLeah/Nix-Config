{ pkgs, ... }:

{
  # File tree
  neo-tree = {
    enable = true;
    settings = {
      popup_border_style = "rounded";
      enable_refresh_on_write = true;
      enable_modified_markers = true;
      enable_git_status = true;
      enable_diagnostics = true;
      close_if_last_window = true;

      buffers = {
        bindToCwd = false;
        follow_current_file.enabled = true;
      };
      filesystem = {
        follow_current_file.enabled = true;

        filteredItems = {
          hideDotfiles = false;
          hideGitignored = false;
        };
      };
      window = {
        width = 40;
        height = 15;
        auto_expand_width = false;
      };
    };

  };
  web-devicons = {
    enable = true;
  };
}
