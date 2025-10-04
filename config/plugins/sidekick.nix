{
  lib,
  ...
}:

{
  plugins.sidekick = {
    enable = true;
    settings = {
      nes.enabled = true;
      mux = {
        enabled = true;
        backend = "tmux";
      };
    };
  };

  # NOTE: requires nvim 0.12+
  # FIXME: migrate to options.nix when supported in nixvim
  extraConfigLua = ''
    vim.lsp.inline_completion.enable()
  '';

  lsp.servers.copilot.enable = true;

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
      key = "<C-.>";
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
