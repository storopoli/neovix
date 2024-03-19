{ pkgs, ... }:

{
  plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = telescope-nvim; # Telescope

      event = "VimEnter";

      dependencies = [
        plenary-nvim

        {
          pkg = telescope-fzf-native-nvim;
          cond = ''
            function()
              return vim.fn.executable("make") == 1
            end
          '';
        }

        telescope-ui-select-nvim
      ];

      keys = {
        __raw = ''
          {
            { "<leader>.", "<CMD>Telescope oldfiles<CR>", desc = "[.] Find recently opened files" },
            { "<leader><space>", "<CMD>Telescope buffers<CR>", desc = "[ ] Find existing buffers" },
            {
              "<leader>/",
              function()
                require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                  winblend = 10,
                  previewer = false,
                }))
              end,
              desc = "[/] Fuzzily search in current buffer",
            },
            {
              "<leader>s/",
              function()
                require("telescope.builtin").live_grep({
                  grep_open_files = true,
                  prompt_title = "Live Grep in Open Files",
                })
              end,
              desc = "[S]earch [/] in Open Files",
            },
            { "<leader>sr", "<CMD>Telescope resume<CR>", desc = "[R]esume Previous Search" },
            { "<leader>sf", "<CMD>Telescope git_files<CR>", desc = "[F]iles" },
            { "<leader>sF", "<CMD>Telescope find_files<CR>", desc = "[F]iles All" },
            { "<leader>sh", "<CMD>Telescope help_tags<CR>", desc = "[H]elp" },
            { "<leader>sw", "<CMD>Telescope grep_string<CR>", desc = "Current [W]ord" },
            { "<leader>sg", "<CMD>Telescope live_grep<CR>", desc = "[G]rep" },
            { "<leader>sd", "<CMD>Telescope diagnostics<CR>", desc = "[D]iagnostics" },
            { "<leader>sm", "<CMD>Telescope marks<CR>", desc = "[M]arks" },
            { "<leader>sc", "<CMD>Telescope git_bcommits<CR>", desc = "[C]omits File" },
            { "<leader>sC", "<CMD>Telescope git_commits<CR>", desc = "[C]omits" },
            { "<leader>ss", "<CMD>Telescope git_status<CR>", desc = "[S]tatus" },
            { "<leader>sS", "<CMD>Telescope git_stash<CR>", desc = "[S]tash" },
            { "<leader>sT", "<CMD>Telescope git_stash<CR>", desc = "[T]reesitter" },
          }
        '';
      };

      config = ''
        function()
          require("telescope").setup({
            extensions = {
              ["ui-select"] = {
                require("telescope.themes").get_dropdown(),
              },
            },
          })
          -- Enable telescope extensions, if they are installed
          pcall(require("telescope").load_extension, "fzf")
          pcall(require("telescope").load_extension, "ui-select")
        end
      '';
    }

    {
      pkg = telescope-file-browser-nvim;
      dependencies = [
        telescope-nvim
        plenary-nvim
      ];
      config = ''
        function()
          -- You don't need to set any of these options.
          -- IMPORTANT!: this is only a showcase of how you can set default options!
          require("telescope").setup({
            extensions = {
              file_browser = {
                -- disables netrw and use telescope-file-browser in its place
                hijack_netrw = true,
              },
            },
          })
          -- To get telescope-file-browser loaded and working with telescope,
          -- you need to call load_extension, somewhere after setup function:
          pcall(require("telescope").load_extension, "file_browser")
        end
      '';
      keys = {
        __raw = ''
          {
            { "<leader>sb", "<CMD>Telescope file_browser<CR>", desc = "File [B]rowser" },
            {
              "<leader>sB",
              "<CMD>Telescope file_browser path=%:p:h select_buffer=true<CR>",
              desc = "File [B]rowser Current Buffer",
            },
          }
        '';
      };
    }
  ];
}

