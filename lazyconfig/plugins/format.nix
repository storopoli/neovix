{ pkgs, ... }:

{
  plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = conform-nvim;

      event = "VeryLazy";

      config = ''
        function()
          require("conform").setup({
            formatters_by_ft = {
              lua = { "stylua" },
              rust = { "rustfmt" },
              nix = { "nixpkgs_fmt" },
              -- Conform will run multiple formatters sequentially
              python = { "isort", "black", "ruff_fix", "ruff_format" },
              sh = { "shfmt", "shellharden" },
              fish = { "fish_indent" },
              toml = { "taplo" },
              markdown = { "markdownlint-cli2" },
              -- Use a sub-list to run only the first available formatter
              html = { { "prettierd", "prettier" } },
              css = { { "prettierd", "prettier" } },
              javascript = { { "prettierd", "prettier" } },
              typescript = { { "prettierd", "prettier" } },
              json = { "dprint" },
              just = { "just" },
              typst = { "typstfmt" },
              ["_"] = { "trim_whitespace" },
            },
            format_on_save = function(bufnr)
              -- Disable with a global or buffer-local variable
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end
              return { timeout_ms = 500, lsp_fallback = "always" }
            end,
          })
          vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
              -- FormatDisable! will disable formatting just for this buffer
              vim.b.disable_autoformat = true
            else
              vim.g.disable_autoformat = true
            end
          end, {
            desc = "Disable autoformat-on-save",
            bang = true,
          })
          vim.keymap.set("", "<leader>f", function()
            require("conform").format({ async = true, lsp_fallback = "always" })
          end, { desc = "[F]ormat" })
          vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
          end, {
            desc = "Re-enable autoformat-on-save",
          })
          vim.keymap.set("n", "<leader>F", function()
            if vim.b.disable_autoformat or vim.g.disable_autoformat then
              require("notify")("conform.nvim - autoformat enabled for current buffer")
              vim.cmd("FormatEnable")
            else
              require("notify")("conform.nvim - autoformat disabled for current buffer")
              vim.cmd("FormatDisable")
            end
          end, { desc = "Toggle [F]ormat" })
        end
      '';
    }
  ];

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
}

