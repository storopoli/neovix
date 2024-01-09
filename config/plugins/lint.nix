{ pkgs, ... }:

{
  plugins.lint = {
    enable = true;

    lintersByFt = {
      python = [ "ruff" ];
      lua = [ "luacheck" ];
      sh = [ "shellcheck" ];
      nix = [ "nix" ];
      javascript = [ "eslint_d" ];
      javascriptreact = [ "eslint_d" ];
      typescript = [ "eslint_d" ];
      typescriptreact = [ "eslint_d" ];
    };

    autoCmd = {
      callback = {
        __raw = ''
          function()
            require('lint').try_lint()
          end
        '';
      };

      event = [ "InsertLeave" "BufWritePost" ];
    };
  };

  extraPackages = with pkgs; [
    ruff
    luajitPackages.luacheck
    shellcheck
    eslint_d
  ];
}
