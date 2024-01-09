{
  plugins.treesitter = {
    enable = true;

    ensureInstalled = [
      "bash"
      "bibtex"
      "c"
      "css"
      "csv"
      "cpp"
      "dockerfile"
      "dot"
      "fish"
      "go"
      "html"
      "javascript"
      "jsdoc"
      "json"
      "julia"
      "latex"
      "llvm"
      "lua"
      "luadoc"
      "luap"
      "make"
      "markdown"
      "markdown_inline"
      "mlir"
      "python"
      "query"
      "regex"
      "rst"
      "rust"
      "ssh_config"
      "sql"
      "tsv"
      "tsx"
      "typescript"
      # "typst"
      "toml"
      "vim"
      "vimdoc"
      "yaml"
      "zig"
    ];

    indent = true;

    incrementalSelection = {
      enable = true;

      keymaps = {
        initSelection = "<C-space>";
        nodeIncremental = "<C-space>";
        scopeIncremental = "<C-space>";
        nodeDecremental = "<M-space>";
      };
    };
  };

  plugins.treesitter-textobjects = {
    enable = true;

    select = {
      enable = true;

      lookahead = true;

      keymaps = {
        # You can use the capture groups defined in textobjects.scm
        "aa" = "@parameter.outer";
        "ia" = "@parameter.inner";
        "af" = "@function.outer";
        "if" = "@function.inner";
        "ac" = "@class.outer";
        "ic" = "@class.inner";
      };
    };

    move = {
      enable = true;

      setJumps = true;

      gotoNextStart = {
        "]m" = "@function.outer";
        "]]" = "@class.outer";
      };

      gotoNextEnd = {
        "]M" = "@function.outer";
        "][" = "@class.outer";
      };

      gotoPreviousStart = {
        "[m" = "@function.outer";
        "[[" = "@class.outer";
      };

      gotoPreviousEnd = {
        "[M" = "@function.outer";
        "[]" = "@class.outer";
      };
    };

    swap = {
      enable = true;

      swapNext = {
        "<leader>a" = "@parameter.inner";
      };

      swapPrevious = {
        "<leader>A" = "@parameter.inner";
      };
    };
  };

  plugins.treesitter-context.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "[c";
      action = ''
        function()
          require("treesitter-context").go_to_context()
        end
      '';
      options = { desc = "Go to [C]context"; };
      lua = true;
    }

  ];
}
