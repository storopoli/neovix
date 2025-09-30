{
  plugins.yazi = {
    enable = true;
    settings = {
      enable_mouse_support = true;
      yazi_floating_window_winblend = 0; # fix issue with wrong background
      open_for_directories = true;
      highlight_hovered_buffers_in_same_directory = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<CMD>Yazi cwd<CR>";
      options = {
        silent = true;
        desc = "Open the file manager in nvim's working directory";
      };
    }
    {
      mode = "n";
      key = "<leader>E";
      action = "<CMD>Yazi<CR>";
      options = {
        silent = true;
        desc = "Open yazi at the current file";
      };
    }
  ];
}
