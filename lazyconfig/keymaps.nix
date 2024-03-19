{
  # Basic Keymaps
  # Set <space> as the leader key
  #  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  # Keymaps for better default experience
  # See `:help vim.keymap.set()`
  keymaps = [
    { mode = [ "n" "v" ]; key = "<Space>"; action = "<Nop>"; options = { silent = true; }; }
    { mode = "n"; key = "Q"; action = "<Nop>"; }

    # Move to window using the <ctrl> hjkl keys
    { mode = "n"; key = "<C-h>"; action = "<C-w>h"; options = { desc = "Go to left window"; remap = true; }; }
    { mode = "n"; key = "<C-j>"; action = "<C-w>j"; options = { desc = "Go to lower window"; remap = true; }; }
    { mode = "n"; key = "<C-k>"; action = "<C-w>k"; options = { desc = "Go to upper window"; remap = true; }; }
    { mode = "n"; key = "<C-l>"; action = "<C-w>l"; options = { desc = "Go to right window"; remap = true; }; }

    # Resize window using <ctrl> arrow keys
    { mode = "n"; key = "<C-Up>"; action = "<CMD>resize +2<CR>"; options = { desc = "Increase window height"; }; }
    { mode = "n"; key = "<C-Down>"; action = "<CMD>resize -2<CR>"; options = { desc = "Decrease window height"; }; }
    { mode = "n"; key = "<C-Left>"; action = "<CMD>vertical resize -2<CR>"; options = { desc = "Decrease window width"; }; }
    { mode = "n"; key = "<C-Right>"; action = "<CMD>vertical resize +2<CR>"; options = { desc = "Increase window width"; }; }

    # Better movement
    { mode = "n"; key = "J"; action = "mzJ`z"; }
    { mode = "n"; key = "<C-d>"; action = "<C-d>zz"; }
    { mode = "n"; key = "<C-u>"; action = "<C-u>zz"; }
    { mode = "n"; key = "n"; action = "nzzzv"; }
    { mode = "n"; key = "N"; action = "Nzzzv"; }

    # Better indenting
    { mode = "v"; key = "<"; action = "<gv"; }
    { mode = "v"; key = ">"; action = ">gv"; }

    # Clear search, diff update and redraw
    # taken from runtime/lua/_editor.lua
    {
      mode = "n";
      key = "<leader>R";
      action = "<CMD>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>";
      options = { desc = "[R]edraw / clear hlsearch / diff update"; };
    }

    # J/K to move up/down visual lines
    { mode = "v"; key = "J"; action = ":m '>+1<CR>gv=gv"; }
    { mode = "v"; key = "K"; action = ":m '<-2<CR>gv=gv"; }

    # Remap for dealing with word wrap
    { mode = "n"; key = "k"; action = "v:count == 0 ? 'gk' : 'k'"; options = { expr = true; silent = true; }; }
    { mode = "n"; key = "j"; action = "v:count == 0 ? 'gj' : 'j'"; options = { expr = true; silent = true; }; }

    # Spell
    { mode = [ "n" "v" ]; key = "<leader>S"; action = "<CMD>setlocal spell!<CR>"; options = { desc = "Set [S]pell"; }; }

    # Easy save
    { mode = "n"; key = "<leader>w"; action = "<CMD>w<CR>"; options = { silent = true; desc = "[S]ave File"; }; }

    # Easy Quit
    { mode = "n"; key = "<leader>q"; action = "<CMD>q<CR>"; options = { silent = true; desc = "[Q]uit"; }; }
    { mode = "n"; key = "<leader>Q"; action = "<CMD>qa!<CR>"; options = { silent = true; desc = "[Q]uit Force All"; }; }

    # Split window
    { mode = "n"; key = "<leader>-"; action = "<C-W>s"; options = { desc = "Split window below"; remap = true; }; }
    { mode = "n"; key = "<leader>|"; action = "<C-W>v"; options = { desc = "Split window right"; remap = true; }; }

    # Global Yank/Paste
    {
      mode = [ "n" "v" ];
      key = "<leader>y";
      action = ''"+y'';
      options = { noremap = true; silent = true; desc = "Global [Y]ank"; };
    }
    { mode = "x"; key = "<leader>p"; action = ''"+p''; options = { noremap = true; silent = true; desc = "Global [P]aste"; }; }
  ];

}
