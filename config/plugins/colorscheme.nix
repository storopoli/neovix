{
  colorschemes.gruvbox = {
    enable = true;
    settings = {
      contrast_dark = "hard";
      transparent_mode = true;
      terminal_colors = true;
    };
  };

  opts = {
    termguicolors = true;
    background = "dark";
  };

  # Custom highlight overrides
  extraConfigLua = ''
    vim.cmd(":hi statusline guibg=NONE")
  '';
}
