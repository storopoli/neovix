{ pkgs, ... }:

{
  plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = nvim-treesitter.withAllGrammars;

      event = [ "BufReadPost" "BufNewFile" ];

      dependencies = [
        nvim-treesitter-textobjects
      ];

      config = ''
        function()
          require("nvim-treesitter.configs").setup({
            ensure_installed = {},
            auto_install = false,
            highlight = { enable = true },
            indent = { enable = true, disable = { "python" } },
            incremental_selection = {
              enable = true,
              keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = "<C-space>",
                node_decremental = "<M-space>",
              },
            },
            textobjects = {
              select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                keymaps = {
                  -- You can use the capture groups defined in textobjects.scm
                  ["aa"] = "@parameter.outer",
                  ["ia"] = "@parameter.inner",
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",
                  ["ac"] = "@class.outer",
                  ["ic"] = "@class.inner",
                },
              },
              move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                  ["]m"] = "@function.outer",
                  ["]]"] = "@class.outer",
                },
                goto_next_end = {
                  ["]M"] = "@function.outer",
                  ["]["] = "@class.outer",
                },
                goto_previous_start = {
                  ["[m"] = "@function.outer",
                  ["[["] = "@class.outer",
                },
                goto_previous_end = {
                  ["[M"] = "@function.outer",
                  ["[]"] = "@class.outer",
                },
              },
              swap = {
                enable = true,
                swap_next = { ["<leader>a"] = "@parameter.inner" },
                swap_previous = { ["<leader>A"] = "@parameter.inner" },
              },
            },
            extensions = {
              fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
              },
            },
          })
          require("telescope").load_extension("fzf")
        end
      '';
    }

    {
      pkg = nvim-treesitter-context;
      dependencies = [ nvim-treesitter ];
      event = [ "BufReadPost" "BufNewFile" ];
      config = true;
      keys = {
        __raw = ''
          {
            {
              "[c",
              function()
                require("treesitter-context").go_to_context()
              end,
              desc = "Go to [C]context",
            },
          }
        '';
      };
    }
  ];
}
