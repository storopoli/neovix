{ lib, ... }:

{
  keymaps = [
    {
      mode = "n";
      key = "<leader>t";
      action = "<CMD>split | wincmd j | terminal env INSIDE_NEOVIM=1 fish<CR>i";
      options.silent = true;
    }
    {
      mode = "t";
      key = "<Esc>";
      action = "<C-\\><C-n>";
      options.silent = true;
    }
  ];

  autoCmd = [
    {
      event = "TermOpen";
      desc = "Terminal keymaps";
      callback = lib.nixvim.mkRaw ''
        function()
          vim.keymap.set("n", "q", "<CMD>q<CR>", { buffer = true, silent = true })
        end
      '';
    }
  ];
}
