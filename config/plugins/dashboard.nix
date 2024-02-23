{
  plugins.dashboard = {
    enable = true;

    theme = "doom";
    hideStatusline = true;
    hideTabline = true;

    # Reads off of `dashboard-header.txt` to set the header ASCII art.
    weekHeader = {
      enable = true;

      concat = ''
        This is my editor. There are many like it, but this one is mine.
        My editor is my best friend. It is my life.
        I must master it as I must master my life.
        Without me my editor is useless. Without my editor, I am useless.
      '';

      append = [
        "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗"
        "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║"
        "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║"
        "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
        "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
        "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
        "                                                  "
      ];
    };

    center = [
      { action = "Telescope find_files"; desc = " Find file"; icon = " "; key = "f"; }
      { action = "ene | startinsert"; desc = " New file"; icon = " "; key = "n"; }
      { action = "Telescope oldfiles"; desc = " Recent files"; icon = " "; key = "r"; }
      { action = "Telescope live_grep"; desc = " Find text"; icon = " "; key = "g"; }
      { action = ''lua require("lazygit").lazygit()''; desc = " Git"; icon = " "; key = "i"; }
      { action = ''lua require("persistence").load()''; desc = " Restore Session"; icon = " "; key = "s"; }
      { action = "qa"; desc = " Quit"; icon = " "; key = "q"; }
    ];
  };
}
