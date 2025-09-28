{
  autoCmd = [
    {
      event = "BufRead";
      group = "RestoreGroup";
      pattern = "*";
      command = ''call setpos(".", getpos("'\""))'';
      desc = "Restore cursor position";
    }
  ];

  autoGroups.RestoreGroup.clear = true;
}

