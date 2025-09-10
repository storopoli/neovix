{ ... }:

{
  plugins.fzf-lua = {
    enable = true;
    keymaps = {
      "<C-p>" = "global";
      "<C-g>" = "grep";
      "<C-l>" = "live_grep";
      "<C-\\>" = "buffers";
      "gs" = "lsp_document_symbols";
      "gS" = "lsp_live_workspace_symbols";
      "<C-k>" = "diagnostics_workspace";
    };
  };
}
