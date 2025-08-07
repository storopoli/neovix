{
  plugins.fugitive = {
    enable = true;
  };

  extraConfigLua = ''
    local pre_commit_check = function()
      local cmd = "split | wincmd j | terminal pre-commit run --all-files"
      vim.cmd(cmd)
    end

    local setup_fugitive_keymaps = function(bufnr)
      local opts = { buffer = bufnr, silent = true }

      vim.keymap.set("n", "<leader>gs", "<CMD>Git<CR>", opts)
      vim.keymap.set("n", "<leader>ga", "<CMD>Gwrite<CR>", opts)
      vim.keymap.set("n", "<leader>gA", "<CMD>Git add .<CR>", opts)
      vim.keymap.set("n", "<leader>gc", "<CMD>Git commit --no-verify<CR>", opts)
      vim.keymap.set("n", "<leader>gv", pre_commit_check, opts)
      vim.keymap.set("n", "<leader>gp", "<CMD>Git pull<CR>", opts)
      vim.keymap.set("n", "<leader>gP", "<CMD>Git push<CR>", opts)
      vim.keymap.set("n", "<leader>gd", "<CMD>Gvdiffsplit<CR>", opts)
      vim.keymap.set("n", "<leader>gD", "<CMD>GDelete<CR>", opts)
      vim.keymap.set("n", "<leader>gl", "<CMD>Git log --oneline<CR>", opts)
      vim.keymap.set("n", "<leader>gf", "<CMD>Git fetch<CR>", opts)
      vim.keymap.set("n", "<leader>gF", "<CMD>Git pull<CR>", opts)
      vim.keymap.set("n", "<leader>gS", "<CMD>Git stash<CR>", opts)

      -- Branch operations
      vim.keymap.set("n", "<leader>gbn", function()
        vim.ui.input({ prompt = "Branch name: " }, function(branch)
          if branch then
            vim.cmd("Git checkout -b " .. branch)
          end
        end)
      end, opts)
      vim.keymap.set("n", "<leader>gbc", function()
        vim.ui.input({ prompt = "Branch to checkout: " }, function(branch)
          if branch then
            vim.cmd("Git checkout " .. branch)
          end
        end)
      end, opts)
      vim.keymap.set("n", "<leader>gbl", "<CMD>Git branch<CR>", opts)
      vim.keymap.set("n", "<leader>gbb", "<CMD>Git blame<CR>", opts)
    end

    -- Only toggle fugitive if we are in a git repo
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        if vim.fs.root(0, ".git") then
          setup_fugitive_keymaps(0)
        end
      end
    })

    -- Fugitive buffer-specific keymaps
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fugitive",
      callback = function()
        vim.keymap.set("n", "q", "<CMD>q<CR>", { buffer = true, silent = true })
      end
    })
  '';
}
