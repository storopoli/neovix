{ lib, ... }:
{
  autoCmd = [
    {
      event = "TextYankPost";
      group = "YankHighlight";
      pattern = "*";
      callback = lib.nixvim.mkRaw "function() vim.highlight.on_yank() end";
      desc = "Highlight yanked text";
    }
  ];

  autoGroups.YankHighlight.clear = true;
}
