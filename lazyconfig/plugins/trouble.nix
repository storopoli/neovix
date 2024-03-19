{ pkgs, ... }:

{
  plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = trouble-nvim;

      dependencies = [ nvim-web-devicons ];

      keys = {
        __raw = ''
          {
            {
              "<leader>xx",
              function()
                require("trouble").toggle()
              end,
              desc = "Trouble",
            },
            {
              "<leader>xw",
              function()
                require("trouble").toggle("workspace_diagnostics")
              end,
              desc = "Trouble [W]orkspace Diagnostics",
            },
            {
              "<leader>xd",
              function()
                require("trouble").toggle("document_diagnostics")
              end,
              desc = "Trouble [D]ocument Diagnostics",
            },
            {
              "<leader>xq",
              function()
                require("trouble").toggle("quickfix")
              end,
              desc = "Trouble [Q]uickfix",
            },
            {
              "<leader>xl",
              function()
                require("trouble").toggle("loclist")
              end,
              desc = "Trouble [L]oclist",
            },
            {
              "gR",
              function()
                require("trouble").toggle("lsp_references")
              end,
              desc = "Trouble LSP [R]eferences",
            },
          }
        '';
      };
    }
  ];
}

