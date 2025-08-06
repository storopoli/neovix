{
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  keymaps = [
    # Leader key disable
    {
      mode = [
        "n"
        "v"
      ];
      key = "<Space>";
      action = "<Nop>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "Q";
      action = "<nop>";
    }

    # Better movement
    {
      mode = "n";
      key = "J";
      action = "mzJ`z";
    }
    {
      mode = "n";
      key = "<C-d>";
      action = "<C-d>zz";
    }
    {
      mode = "n";
      key = "<C-u>";
      action = "<C-u>zz";
    }
    {
      mode = "n";
      key = "n";
      action = "nzzzv";
    }
    {
      mode = "n";
      key = "N";
      action = "Nzzzv";
    }

    # Better indenting
    {
      mode = "v";
      key = "<";
      action = "<gv";
    }
    {
      mode = "v";
      key = ">";
      action = ">gv";
    }

    # Clear search
    {
      mode = [
        "i"
        "n"
      ];
      key = "<ESC>";
      action = "<CMD>noh<CR><esc>";
    }
    {
      mode = "n";
      key = "<leader>R";
      action = "<CMD>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>";
    }

    # Move lines
    {
      mode = "v";
      key = "J";
      action = ":m '>+1<CR>gv=gv";
    }
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
    }
    {
      mode = "n";
      key = "<A-j>";
      action = "<CMD>m .+1<CR>==";
    }
    {
      mode = "n";
      key = "<A-k>";
      action = "<CMD>m .-2<CR>==";
    }
    {
      mode = "i";
      key = "<A-j>";
      action = "<ESC><CMD>m .+1<CR>==gi";
    }
    {
      mode = "i";
      key = "<A-k>";
      action = "<ESC><CMD>m .-2<CR>==gi";
    }
    {
      mode = "v";
      key = "<A-j>";
      action = ":m '>+1<CR>gv=gv";
    }
    {
      mode = "v";
      key = "<A-k>";
      action = ":m '<-2<CR>gv=gv";
    }

    # Word wrap
    {
      mode = "n";
      key = "k";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        expr = true;
        silent = true;
      };
    }
    {
      mode = "n";
      key = "j";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        expr = true;
        silent = true;
      };
    }

    # Quick actions
    {
      mode = "n";
      key = "<leader>w";
      action = "<CMD>w<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>q";
      action = "<CMD>q<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>Q";
      action = "<CMD>qa!<CR>";
      options.silent = true;
    }

    # Terminal
    {
      mode = "n";
      key = "<leader>t";
      action = "<CMD>split | wincmd j | terminal env INSIDE_NEOVIM=1 fish<CR>i";
      options.silent = true;
    }
    {
      mode = "t";
      key = "<Esc>";
      action = "<C-\\><C-n>";
      options.silent = true;
    }

    # Global yank
    {
      mode = [
        "n"
        "v"
        "x"
      ];
      key = "<leader>y";
      action = ''"+y"'';
      options = {
        noremap = true;
        silent = true;
      };
    }

    # Quickfix/Location lists
    {
      mode = "n";
      key = "]q";
      action = "<CMD>cnext<CR>zz";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "n";
      key = "[q";
      action = "<CMD>cprev<CR>zz";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "n";
      key = "]l";
      action = "<CMD>lnext<CR>zz";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "n";
      key = "[l";
      action = "<CMD>lprev<CR>zz";
      options = {
        noremap = true;
        silent = true;
      };
    }

    # Netrw
    {
      mode = "n";
      key = "<C-p>";
      action.__raw = "vim.cmd.Lexplore";
    }
    {
      mode = "n";
      key = "<C-q>";
      action = "<CMD>Lexplore %:h<CR>";
    }
  ];
}
