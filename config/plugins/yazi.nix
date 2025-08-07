{
  plugins.yazi = {
    enable = true;
    settings = {
      yazi_floating_window_winblend = 5;
      open_for_directories = true;
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
