{
  plugins.gitsigns = {
    enable = true;

    settings = {
      on_attach = ''
        function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]h", bang = true })
            else
              gs.nav_hunk("next")
            end
          end)

          map("n", "[h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[h", bang = true })
            else
              gs.nav_hunk("prev")
            end
          end)

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk)
          map("n", "<leader>hr", gs.reset_hunk)
          map("v", "<leader>hs", function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
          map("v", "<leader>hr", function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end)
          map("n", "<leader>hS", gs.stage_buffer)
          map("n", "<leader>hu", gs.undo_stage_hunk)
          map("n", "<leader>hR", gs.reset_buffer)
          map("n", "<leader>hp", gs.preview_hunk)
          map("n", "<leader>hi", gs.preview_hunk_inline)
          map("n", "<leader>hb", gs.blame_line)
          map("n", "<leader>hB", gs.blame)
          map("n", "<leader>hd", gs.diffthis)
          map("n", "<leader>hD", function() gs.diffthis("~") end)
          map("n", "<leader>hQ", function() gs.setqflist("all") end)
          map("n", "<leader>hq", gs.setqflist)

          -- Toggles
          map("n", "<leader>tb", gs.toggle_current_line_blame)
          map("n", "<leader>tw", gs.toggle_word_diff)

          -- Text object
          map({"o", "x"}, "ih", gs.select_hunk)
        end
      '';
    };
  };
}
