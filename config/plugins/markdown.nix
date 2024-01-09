{
  plugins.markdown-preview.enable = true;
  keymaps = [
    { mode = "n"; key = "<leader>m"; action = "<CMD>MarkdownPreview<CR>"; options = { desc = "[M]arkdown Preview"; }; }
  ];
}
