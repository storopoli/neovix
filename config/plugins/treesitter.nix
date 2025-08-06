{ lib, ... }:

{
  plugins = {
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        sync_install = false;
        auto_install = false;
        ignore_install = [ ];
        additional_vim_regex_highlighting = false;

        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "<c-space>";
            node_incremental = "<c-space>";
            scope_incremental = "<c-s>";
            node_decremental = "<M-space>";
          };
        };

        indent.enable = true;

        textobjects = {
          select = {
            enable = true;
            lookahead = true;
            keymaps = {
              "aa" = "@parameter.outer";
              "ia" = "@parameter.inner";
              "af" = "@function.outer";
              "if" = "@function.inner";
              "ac" = "@class.outer";
              "ic" = {
                query = "@class.inner";
                desc = "Select inner part of a class region";
              };
              "as" = {
                query = "@local.scope";
                query_group = "locals";
                desc = "Select language scope";
              };
            };
            selection_modes = {
              "@parameter.outer" = "v";
              "@function.outer" = "V";
              "@class.outer" = "<c-v>";
            };
            include_surrounding_whitespace = true;
          };
          move = {
            enable = true;
            set_jumps = true;
            goto_next_start = {
              "]m" = "@function.outer";
              "]]" = {
                query = "@class.outer";
                desc = "Next class start";
              };
              "]o" = "@loop.*";
              "]s" = {
                query = "@local.scope";
                query_group = "locals";
                desc = "Next scope";
              };
              "]z" = {
                query = "@fold";
                query_group = "folds";
                desc = "Next fold";
              };
            };
            goto_next_end = {
              "]M" = "@function.outer";
              "][" = "@class.outer";
            };
            goto_previous_start = {
              "[m" = "@function.outer";
              "[[" = "@class.outer";
            };
            goto_previous_end = {
              "[M" = "@function.outer";
              "[]" = "@class.outer";
            };
          };
        };
      };

      # Use all grammars
      nixGrammars = true;
    };

    treesitter-context = {
      enable = true;
    };
  };

  # Custom keymaps and options for treesitter
  opts = {
    foldmethod = "expr";
    foldexpr = lib.nixvim.mkRaw "vim.treesitter.foldexpr()";
    foldminlines = 500;
  };

  keymaps = [
    {
      mode = "n";
      key = "[c";
      action = lib.nixvim.mkRaw ''
        function()
          require("treesitter-context").go_to_context(vim.v.count1)
        end
      '';
      options.silent = true;
    }
  ];

  extraConfigLua = ''
    vim.cmd("hi TreesitterContextBottom gui=underline guisp=Grey")
    vim.cmd("hi TreesitterContextLineNumberBottom gui=underline guisp=Grey")
  '';
}
