{ ... }:

{
  plugins.fzf-lua = {
    enable = true;
    keymaps = {
      "<C-p>" = "global";
      "<C-g>" = "grep";
      "<C-l>" = "live_grep";
      "<C-\\>" = "buffers";
    };
  };
}
