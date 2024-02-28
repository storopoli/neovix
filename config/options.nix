{
  config.options = {
    # Set highlight on search
    hlsearch = false;
    incsearch = true;

    # Make line numbers default
    nu = true;
    relativenumber = true;

    # Tab settings
    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;
    expandtab = true;

    # Lazy redraw for crazy macros
    #lazyredraw = true;

    # A lot of plugins depends on hidden true
    hidden = true;

    # set command line height to zero/two lines
    # cmdheight = 2;
    cmdheight = 0;

    # Statusbar
    laststatus = 3;

    # Winbar on top of the windows
    winbar = "%=%m %f";

    # Enable mouse mode
    mouse = "a";

    # Scrolling
    scrolloff = 8;
    sidescrolloff = 8;

    # Time in milliseconds to wait for a mapped sequence to complete
    timeoutlen = 50;
    ttyfast = true;
    updatetime = 50;

    # No wrap
    wrap = false;

    # Enable break indent
    breakindent = true;

    # Better undo history
    swapfile = false;
    backup = false;
    undodir = { __raw = "os.getenv('HOME') .. '/.cache/nvim/undodir'"; };
    undofile = true;

    # Case insensitive searching UNLESS /C or capital in search
    ignorecase = true;
    smartcase = true;

    # color column
    colorcolumn = "80";
    signcolumn = "yes";

    # Window splitting
    splitbelow = true;
    splitright = true;

    # Transparency
    winblend = 5;
    termguicolors = true;

    # If enabled, Neovim will search for the following files in the current directory:
    # - .nvim.lua
    # - .nvimrc
    # - .exrc
    # Add files with `:trust`, remove with `:trust ++remove`
    exrc = true;
  };
}
