{
  plugins.todo-comments.enable = true;

  keymaps = [
    { mode = "n"; key = "<leader>st"; action = "<CMD>TodoTelescope<CR>"; options = { desc = "[T]odo"; }; }
    { mode = "n"; key = "<leader>K"; action = "<CMD>TodoLocList<CR>"; options = { desc = "Todo: List"; }; }
    { mode = "n"; key = "<leader>[t"; action = "<CMD>lua require('todo-comments').jump_prev()<CR>"; options = { desc = "Previous [T]odo"; }; }
    { mode = "n"; key = "<leader>]t"; action = "<CMD>lua require('todo-comments').jump_next()<CR>"; options = { desc = "Next [T]odo"; }; }
  ];
}
