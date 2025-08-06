{ lib, ... }:

{
  globals = {
    netrw_browse_split = 0;
    netrw_banner = 0;
    netrw_winsize = 25;
  };

  keymaps = [
    {
      mode = "n";
      key = "<C-p>";
      action = lib.nixvim.mkRaw "vim.cmd.Lexplore";
    }
    {
      mode = "n";
      key = "<C-q>";
      action = "<CMD>Lexplore %:h<CR>";
    }
  ];

  autoCmd = [
    {
      event = "FileType";
      pattern = "netrw";
      desc = "Better mappings for netrw";
      callback = lib.nixvim.mkRaw ''
        function()
          -- edit new file
          vim.keymap.set("n", "n", "%", { remap = true, buffer = true })
          -- rename file
          vim.keymap.set("n", "r", "R", { remap = true, buffer = true })
          -- delete file/dir
          vim.keymap.set("n", "d", "D", { remap = true, buffer = true })
          -- back in history
          vim.keymap.set("n", "H", "u", { remap = true, buffer = true })
          -- up a directory
          vim.keymap.set("n", "h", "-^", { remap = true, buffer = true })
          -- open a directory or a file
          vim.keymap.set("n", "l", "<CR>", { remap = true, buffer = true })
          -- toggle the dotfiles
          vim.keymap.set("n", ".", "gh", { remap = true, buffer = true })
          -- close the preview window
          vim.keymap.set("n", "P", "<C-w>z", { remap = true, buffer = true })
          -- open a file and close netrw
          vim.keymap.set("n", "L", "<CR><CMD>Lexplore<CR>", { remap = true, buffer = true })
          -- close netrw using any key that we've opened netrw with
          vim.keymap.set("n", "<leader>q", "<CMD>Lexplore<CR>", { remap = true, buffer = true })
          vim.keymap.set("n", "<C-p>", "<CMD>Lexplore<CR>", { remap = true, buffer = true })
          vim.keymap.set("n", "<C-q>", "<CMD>Lexplore<CR>", { remap = true, buffer = true })
        end
      '';
    }
  ];
}
