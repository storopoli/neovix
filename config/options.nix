{ lib, ... }:

{
  config = {
    opts = {
      # Search & display
      hlsearch = false;
      incsearch = true;
      nu = true;
      relativenumber = true;

      # Indentation
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;

      # A lot of plugins depends on hidden true
      hidden = true;

      # Interface
      laststatus = 3;
      winbar = "%=%m %f";
      mouse = "a";
      scrolloff = 8;
      sidescrolloff = 8;
      timeoutlen = 500;
      ttyfast = true;
      wrap = false;
      breakindent = true;

      # Files & backup
      swapfile = false;
      backup = false;
      undodir = lib.nixvim.mkRaw "vim.fn.stdpath('data') .. '/undo'";
      undofile = true;

      # Search behavior
      ignorecase = true;
      smartcase = true;

      # UI improvements
      updatetime = 500;
      colorcolumn = "80";
      splitbelow = true;
      splitright = true;
      list = true;
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };
      winborder = "rounded";
      # If enabled, Neovim will search for the following files in the current directory:
      # - .nvim.lua
      # - .nvimrc
      # - .exrc
      # Add files with `:trust`, remove with `:trust ++remove`
      exrc = true;
    };

    extraConfigLua = ''
      vim.wo.signcolumn = "yes"
    '';
  };
}
