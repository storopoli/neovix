{
  autoCmd = [
    {
      event = "TextYankPost";
      group = "HighlightYank";
      command = "silent! lua vim.highlight.on_yank{ higroup='IncSearch', timeout=200 }";
    }
  ];

  autoGroups.HighlightYank.clear = true;
}
