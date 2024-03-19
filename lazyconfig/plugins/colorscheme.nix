{ pkgs, ... }:

{
  plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = catppuccin-nvim;

      name = "catppuccin";

      lazy = false;

      priority = 1000;

      config = ''
        function()
          require("catppuccin").setup({
            flavour = "mocha",
            transparent_background = true,
            integrations = {
              native_lsp = {
                enabled = true,
                virtual_text = {
                  errors = { "italic" },
                  hints = { "italic" },
                  warnings = { "italic" },
                  information = { "italic" },
                },
                underlines = {
                  errors = { "underline" },
                  hints = { "underline" },
                  warnings = { "underline" },
                  information = { "underline" },
                },
                inlay_hints = {
                  background = true,
                },
              },
              telescope = {
                enabled = true,
              },
              cmp = true,
              gitsigns = true,
              nvimtree = true,
              treesitter = true,
              markdown = true,
              notify = true,
              lsp_trouble = false,
              fidget = true,
              indent_blankline = true,
              noice = true,
              which_key = true,
            },
          })
          vim.o.termguicolors = true
          vim.cmd.colorscheme("catppuccin")
        end
      '';

      keys = {
        __raw = ''
          {
            { "<leader>l", "<CMD>Lazy<cr>", desc = "[L]azy" },
          }
        '';
      };
    }

    {
      pkg = lualine-nvim;

      event = "VeryLazy";

      dependencies = [ catppuccin-nvim ];

      config = ''
        function()
          require("lualine").setup({
            options = {
              theme = "catppuccin",
            },
          })
        end
      '';
    }

    {
      pkg = nvim-notify;

      config = ''
        function()
          require("notify").setup({
            background_colour = "#000000",
          })
        end
      '';
    }
  ];
}
