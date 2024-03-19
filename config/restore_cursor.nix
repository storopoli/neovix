{
  autoCmd = [
    {
      event = "BufRead";
      group = "RestoreGroup";
      command = ''call setpos(".", getpos("'\""))'';
    }
  ];

  autoGroups.RestoreGroup.clear = true;
}
