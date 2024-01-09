{ pkgs, ... }:

{
  plugins.telescope = {
    enable = true;

    keymaps = {
      "<leader>?" = { action = "oldfiles"; desc = "[?] Find recently opened files"; };
      "<lader><space>" = { action = "buffers"; desc = "[ ] Find existing buffers"; };
      "<leader>/" = { action = "current_buffer_fuzzy_find"; desc = "[/] Fuzzily search in current buffer"; };
      "<leader>sr" = { action = "resume"; desc = "[R]esume Previous Seasch"; };
      "<leader>sf" = { action = "git_files"; desc = "[F]iles"; };
      "<leader>sF" = { action = "find_files"; desc = "[F]iles All"; };
      "<leader>sh" = { action = "help_tags"; desc = "[H]elp"; };
      "<leader>sw" = { action = "grep_string"; desc = "Current [W]ord"; };
      "<leader>sg" = { action = "live_grep"; desc = "[G]rep"; };
      "<leader>sd" = { action = "diagnostics"; desc = "[D]iagnostics"; };
      "<leader>sm" = { action = "marks"; desc = "[M]arks"; };
      "<leader>sc" = { action = "git_bcommits"; desc = "[C]omits File"; };
      "<leader>sC" = { action = "git_commits"; desc = "[C]omits"; };
      "<leader>ss" = { action = "git_status"; desc = "[S]tatus"; };
      "<leader>sS" = { action = "git_stash"; desc = "[S]tash"; };
      "<leader>sT" = { action = "git_stash"; desc = "[T]reesitter"; };
    };

    defaults = {
      mappings = {
        i = {
          "<C-n>" = "move_selection_next";
          "<C-p>" = "move_selection_previous";
        };
      };
    };
  };

  plugins.telescope.extensions.fzf-native.enable = true;

  plugins.telescope.extensions.undo.enable = true;

  plugins.telescope.extensions.file_browser.enable = true;

  keymaps = [
    { mode = "n"; key = "<leader>su"; action = "<CMD>Telescope undo<CR>"; options = { desc = "[U]ndo"; }; }
    { mode = "n"; key = "<leader>sb"; action = "<CMD>Telescope file_browser<CR>"; options = { desc = "File [B]rowser"; }; }
    { mode = "n"; key = "<leader>sB"; action = "<CMD>Telescope file_browser path=%:p:h select_buffer=true<CR>"; options = { desc = "File [B]rowser Current Buffer"; }; }
  ];

  extraPackages = with pkgs; [
    fzf
    fd
  ];

}
