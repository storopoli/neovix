{
  autoGroups = {
    restoreGroup = {
      clear = true;
    };
  };
  autoCmd = [
    {
      event = [ "BufRead" ];
      pattern = "*'";
      group = "restoreGroup";
      command = ''
        [[call setpos(".", getpos("'\""))]]
      '';
    }
  ];
}
