{ pkgs, ... }:

{
  extraPlugins = [ pkgs.vimPlugins.dashboard-nvim ];
  extraConfigLua = ''
    local logo_table = {
      "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
      "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
      "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
      "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
      "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
      "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
      "                                                  ",
    }
    local logo = table.concat(logo_table, "\n")
    logo = string.rep("\n", 8) .. logo .. "\n\n"

    require('dashboard').setup({
      theme = "doom",

      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline,
        tabline,
        winbar,
      },

      config = {
        header = vim.split(logo, "\n"),

        center = {
          { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
          { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
          { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
          { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
          { action = 'lua require("lazygit").lazygit()', desc = " Git", icon = " ", key = "i" },
          { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
          { action = "qa", desc = " Quit", icon = " ", key = "q" },
        },
      },
    })
  '';
}
