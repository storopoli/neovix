{ pkgs, ... }:

{
  plugins.gitsigns = {
    enable = true;

    trouble = true;

    onAttach = {
      function = ''
        function(bufnr)
          local gs = package.loaded.gitsigns
          -- Navigation
          vim.keymap.set("n", "]h", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr, desc = "Next [H]unk" })
          vim.keymap.set("n", "[h", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr, desc = "Previous [H]unk" })
          -- Actions
          vim.keymap.set(
            { "n", "v" },
            "<leader>hs",
            "<CMD>Gitsigns stage_hunk<CR>",
            { buffer = bufnr, desc = "[S]tage" }
          )
          vim.keymap.set(
            { "n", "v" },
            "<leader>hr",
            "<CMD>Gitsigns reset_hunk<CR>",
            { buffer = bufnr, desc = "[R]eset" }
          )
          vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "[S]tage File" })
          vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "[U]ndo" })
          vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "[R]eset File" })
          vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "[P]review" })
          vim.keymap.set("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, { buffer = bufnr, desc = "[B]lame line" })
          vim.keymap.set(
            "n",
            "<leader>hB",
            gs.toggle_current_line_blame,
            { buffer = bufnr, desc = "Toggle [B]lame Line" }
          )
          vim.keymap.set("n", "<leader>hd", gs.diffthis, { buffer = bufnr, desc = "[D]iff This" })
          vim.keymap.set("n", "<leader>hD", function()
            gs.diffthis("~")
          end, { buffer = bufnr, desc = "[D]iff This ~" })
          vim.keymap.set("n", "<leader>ht", gs.toggle_deleted, { buffer = bufnr, desc = "[T]oggle Deleted" })
          -- Text object
          vim.keymap.set(
            { "o", "x" },
            "ih",
            ":<C-U>Gitsigns select_hunk<CR>",
            { buffer = bufnr, desc = "GitSigns Select Hunk" }
          )
        end
      '';
    };
  };

  extraPackages = with pkgs; [
    lazygit
  ];

  extraPlugins = with pkgs.vimPlugins; [
    lazygit-nvim
  ];

  keymaps = [
    { mode = "n"; key = "<leader>gg"; action = "<CMD>LazyGit<CR>"; options = { desc = "Lazy[g]it"; }; }
  ];
}
