{ pkgs, ... }:

{
  plugins.conform-nvim = {
    enable = true;

    formattersByFt = {
      lua = [ "stylua" ];
      nix = [ "nixpkgs_fmt" ];
      # Conform will run multiple formatters sequentially;
      python = [ "isort" "black" "ruff_fix" "ruff_format" ];
      sh = [ "shfmt" "shellharden" ];
      fish = [ "fish_indent" ];
      toml = [ "taplo" ];
      markdown = [ "markdownlint-cli2" ];
      # Use a sub-list to run only the first available formatter;
      html = [ [ "prettierd" "prettier" ] ];
      css = [ [ "prettierd" "prettier" ] ];
      javascript = [ [ "prettierd" "prettier" ] ];
      typescript = [ [ "prettierd" "prettier" ] ];
      just = [ "just" ];
      typst = [ "typstfmt" ];
      "_" = [ "trim_whitespace" ];
    };

    formatOnSave = ''
      function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = "always" }
        end
    '';
  };

  plugins.notify = {
    enable = true;

    backgroundColour = "#000000";
  };

  extraPackages = with pkgs; [
    stylua
    nixpkgs-fmt
    isort
    black
    ruff
    shfmt
    shellharden
    prettierd
    typstfmt
    markdownlint-cli2
  ];

  keymaps = [
    {
      mode = "";
      key = "<leader>f";
      action = ''
        function()
          require("conform").format({ async = true, lsp_fallback = "always" })
        end
      '';
      options = { desc = "[F]ormat"; };
      lua = true;
    }
    {
      mode = "n";
      key = "<leader>F";
      action = ''
        function()
          if vim.b.disable_autoformat or vim.g.disable_autoformat then
            require("notify")("conform.nvim - autoformat enabled for current buffer")
            vim.g.disable_autoformat = false
          else
            require("notify")("conform.nvim - autoformat disabled for current buffer")
            vim.g.disable_autoformat = true
          end
        end
      '';
      options = { desc = "Toggle [F]ormat"; };
      lua = true;
    }
  ];
}
