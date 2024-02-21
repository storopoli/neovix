{
  programs.nixvim = {
    plugins = {
      copilot-lua = {
        enable = true;
        suggestion.enabled = false; # use cmp-copilot instead
        panel.enabled = false; # use cmp-copilot instead
        filetypes = {
          javascript = true;
          typescript = true;
          html = true;
          css = true;
          rust = true;
          python = true;
          java = true;
          c = true;
          cpp = true;
          nix = true;
          lua = true;

          yaml = true;
          markdown = true;
          help = false;
          gitcommit = false;
          gitrebase = false;
          hgcommit = false;
          svn = false;
          cvs = false;
          "." = false;
        };
      };
      copilot-cmp = {
        enable = true;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>cp";
      action = ''
        function()
              if require("copilot.client").is_disabled() then
                vim.cmd("Copilot enable")
              else
                vim.cmd("Copilot disable")
              end
            end'';
      options = { desc = "Co[p]ilot Toggle"; };
      lua = true;
    }
  ];
}
