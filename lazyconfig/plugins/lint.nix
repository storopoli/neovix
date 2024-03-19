{ pkgs, ... }:

{
  plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = nvim-lint;
      config = ''
        function()
          local lint = require("lint")
          lint.linters_by_ft = {
            python = { "ruff" }, -- requires ruff to be installed
            lua = { "luacheck" }, -- requires luacheck to be installed
            sh = { "shellcheck" }, -- requires shellcheck to be installed
            nix = { "nix" }, -- requires nix to be installed
            javascript = { "eslint_d" }, -- requires eslint_d to be installed
            javascriptreact = { "eslint_d" }, -- requires eslint_d to be installed
            typescript = { "eslint_d" }, -- requires eslint_d to be installed
            typescriptreact = { "eslint_d" }, -- requires eslint_d to be installed
          }
          vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
            callback = function()
              lint.try_lint()
            end,
          })
        end
      '';
    }
  ];

  extraPackages = with pkgs; [
    ruff
    luajitPackages.luacheck
    shellcheck
    eslint_d
  ];
}

