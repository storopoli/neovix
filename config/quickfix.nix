{ lib, ... }:

{
  keymaps = [
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
    {
      mode = "n";
      key = "<leader>p";
      action = lib.nixvim.mkRaw ''
        function()
          if vim.bo.filetype == "qf" then
            vim.cmd.cclose()
          else
            vim.cmd.copen()
          end
        end
      '';
      options = {
        silent = true;
      };
    }
  ];

  autoCmd = [
    {
      event = "FileType";
      pattern = "qf";
      desc = "Quickfix/loclist keymaps";
      callback = lib.nixvim.mkRaw ''
        function()
          vim.keymap.set("n", "q", "<CMD>quit<CR>", { buffer = true, noremap = true, silent = true })
          vim.keymap.set("n", "<C-p>", "k", { buffer = true, noremap = true, silent = true })
        end
      '';
    }
    {
      event = "WinClosed";
      desc = "Close quickfix/loclist if only remaining windows";
      callback = lib.nixvim.mkRaw ''
        function()
          vim.schedule(function()
            local wins = vim.api.nvim_tabpage_list_wins(0)
            local only_qf = true
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.api.nvim_get_option_value("buftype", { buf = buf }) ~= "quickfix" then
                only_qf = false
                break
              end
            end
            if only_qf and #wins > 0 then
              vim.cmd.qall()
            end
          end)
        end
      '';
    }
  ];
}
