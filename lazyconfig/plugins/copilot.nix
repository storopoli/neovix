{ pkgs, ... }:

{
  plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = copilot-lua;

      cmd = "Copilot";

      opts = {
        suggestion = { enabled = false; };

        panel = { enabled = false; };

        filetypes = {
          markdown = true;
          help = true;
        };
      };

      keys = {
        __raw = ''
          {
            {
              "<leader>cp",
              function()
                if require("copilot.client").is_disabled() then
                  vim.cmd("Copilot enable")
                else
                  vim.cmd("Copilot disable")
                end
              end,
              desc = "Co[p]ilot Toggle",
            },
          }
        '';
      };
    }

    {
      pkg = copilot-cmp;

      dependencies = [ copilot-lua ];

      config = true;
    }

    # FIXME: whenever this lands in nixpkgs include it back
    /* {
      pkg = copilot-lualine;

      config = ''
        function()
          require("lualine").setup({
            options = {
              icons_enabled = true,
              theme = "auto",
              component_separators = { left = "", right = "" },
              section_separators = { left = "", right = "" },
              disabled_filetypes = {
                statusline = {},
                winbar = {},
              },
              ignore_focus = {},
              always_divide_middle = true,
              globalstatus = false,
              refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
              },
            },
            sections = {
              lualine_a = { "mode" },
              lualine_b = { "branch", "diff", "diagnostics" },
              lualine_c = { "filename" },
              lualine_x = { { "copilot", show_colors = true }, "encoding", "fileformat", "filetype" },
              lualine_y = { "progress" },
              lualine_z = { "location" },
            },
            inactive_sections = {
              lualine_a = {},
              lualine_b = {},
              lualine_c = { "filename" },
              lualine_x = { "location" },
              lualine_y = {},
              lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
          })
        end
      '';
    } */
  ];

  extraPackages = with pkgs; [
    nodejs
  ];
}

