{
  programs.nixvim = {
    plugins = {
      copilot-lua = {
        enable = true;
        suggestion.enabled = false; # use cmp-copilot instead
        panel.enabled = false; # use cmp-copilot instead
      };
      copilot-cmp = {
        enable = true;
      };
    };
  };
}
