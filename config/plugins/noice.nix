{
  plugins.noice = {
    enable = true;

    notify.enabled = true;

    lsp.override = {
      # override markdown rendering so that cmp and other plugins use Treesitter
      "vim.lsp.util.convert_input_to_markdown_lines" = true;
      "vim.lsp.util.stylize_markdown" = true;
      "cmp.entry.get_documentation" = true;
    };

    presets = {
      bottom_search = false; # use a classic bottom cmdline for search
      command_palette = true; # position the cmdline and popupmenu together
      long_message_to_split = true; # long messages will be sent to a split
      inc_rename = false; # enables an input dialog for inc-rename.nvim
      lsp_doc_border = true; # add a border to hover docs and signature help
    };
  };

  keymaps = [
    { mode = "n"; key = "<leader>sn"; action = "<CMD>Telescope noice<CR>"; options = { desc = "[N]oice"; }; }
    {
      mode = "n";
      key = "<leader>nl";
      action = ''function() require("noice").cmd("last") end'';
      options = { desc = "[L]ast Message"; };
      lua = true;
    }
    {
      mode = "n";
      key = "<leader>nh";
      action = ''function() require("noice").cmd("history") end'';
      options = { desc = "[H]istory"; };
      lua = true;
    }
    {
      mode = "n";
      key = "<leader>na";
      action = ''function() require("noice").cmd("all") end'';
      options = { desc = "[A]ll"; };
      lua = true;
    }
    {
      mode = "n";
      key = "<leader>nd";
      action = ''function() require("noice").cmd("dismiss") end'';
      options = { desc = "[D]ismiss All"; };
      lua = true;
    }
    {
      mode = [ "i" "n" "s" ];
      key = "<C-f>";
      action = ''function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end'';
      options = {
        desc = "Scroll [F]orward";
        silent = true;
        expr = true;
      };
      lua = true;
    }
    {
      mode = [ "i" "n" "s" ];
      key = "<C-b>";
      action = ''function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end'';
      options = {
        desc = "Scroll [B]ackward";
        silent = true;
        expr = true;
      };
      lua = true;
    }
  ];
}
