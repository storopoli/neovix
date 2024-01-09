{
  plugins.trouble.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>xx";
      action = ''
        function()
          require("trouble").toggle()
        end
      '';
      options = { desc = "Trouble"; };
      lua = true;
    }
    {
      mode = "n";
      key = "<leader>xw";
      action = ''
        function()
          require("trouble").toggle("workspace_diagnostics")
        end
      '';
      options = { desc = "Trouble [W]orkspace Diagnostics"; };
      lua = true;
    }
    {
      mode = "n";
      key = "<leader>xd";
      action = ''
        function()
          require("trouble").toggle("document_diagnostics")
        end
      '';
      options = { desc = "Trouble [D]ocument Diagnostics"; };
      lua = true;
    }
    {
      mode = "n";
      key = "<leader>xq";
      action = ''
        function()
          require("trouble").toggle("quickfix")
        end
      '';
      options = { desc = "Trouble [Q]uickfix"; };
      lua = true;
    }
    {
      mode = "n";
      key = "<leader>xl";
      action = ''
        function()
          require("trouble").toggle("loclist")
        end
      '';
      options = { desc = "Trouble [L]oclist"; };
      lua = true;
    }
    {
      mode = "n";
      key = "gR";
      action = ''
        function()
          require("trouble").toggle("lsp_references")
        end
      '';
      options = { desc = "Trouble LSP [R]eferences"; };
      lua = true;
    }
  ];
}
