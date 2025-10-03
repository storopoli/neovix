{
  lib,
  pkgs,
  ...
}:

let
  settings = {
    nes.enabled = true;
    mux = {
      enabled = true;
      backend = "tmux";
    };
  };
in

{
  extraPlugins = [
    (pkgs.vimPlugins.sidekick-nvim.overrideAttrs {
      version = "1.2.0";
      src = pkgs.fetchFromGitHub {
        owner = "folke";
        repo = "sidekick.nvim";
        rev = "373b9f71d864209b1ccf64d6c73a434c33c2d67e";
        sha256 = "sha256-so/28fFNL1xZv/SFoAbdRKXx11NvDQ2Nxa5TD8Tmtjs=";
      };
    })
  ];

  extraConfigLua = ''
    require('sidekick').setup(${lib.nixvim.toLuaObject settings})
    vim.lsp.inline_completion.enable()
  '';

  extraPackages = [
    pkgs.github-copilot-cli
  ];

  lsp.servers.copilot = {
    enable = true;

    settings = {
      cmd = [
        "${lib.getExe pkgs.copilot-language-server}"
        "--stdio"
      ];
    };
  };

  keymaps = [
    {
      mode = [
        "n"
        "i"
      ];
      key = "<tab>";
      action = lib.nixvim.mkRaw ''
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if require("sidekick").nes_jump_or_apply() then
            return -- jumped or applied
          end

          -- if you are using Neovim's native inline completions
          -- NOTE: requires nvim 0.12+
          if vim.lsp.inline_completion.get() then
            return
          end

          -- any other things (like snippets) you want to do on <tab> go here.

          -- fall back to normal tab
          return "<tab>"
        end
      '';
      options = {
        expr = true;
        desc = "Goto/Apply Next Edit Suggestion";
      };
    }
    {
      mode = [
        "n"
        "x"
        "i"
        "t"
      ];
      key = "<c-.>";
      action = lib.nixvim.mkRaw ''
        function() require("sidekick.cli").focus() end
      '';
      options.desc = "Sidekick Switch Focus";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>aa";
      action = lib.nixvim.mkRaw ''
        function() require("sidekick.cli").toggle() end
      '';
      options.desc = "Sidekick Toggle CLI";
    }
    {
      mode = "n";
      key = "<leader>as";
      action = lib.nixvim.mkRaw ''
        function() require("sidekick.cli").select() end
      '';
      options.desc = "Sidekick Select CLI";
    }
    {
      mode = "v";
      key = "<leader>as";
      action = lib.nixvim.mkRaw ''
        function() require("sidekick.cli").select({ selection = true }) end
      '';
      options.desc = "Sidekick Send Visual Selection";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>ap";
      action = lib.nixvim.mkRaw ''
        function() require("sidekick.cli").prompt() end
      '';
      options.desc = "Sidekick Select Prompt";
    }
  ];
}
