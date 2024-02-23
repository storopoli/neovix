{
  plugins.persistence.enable = true;
  keymaps = [
    {
      key = "<leader>ts";
      action = ''function() require("persistence").load() end'';
      options = { desc = "Restore Session"; };
      lua = true;
    }
    {
      key = "<leader>tl";
      action = ''function() require("persistence").load({ last = true }) end'';
      options = { desc = "Restore Last Session"; };
      lua = true;
    }
    {
      key = "<leader>td";
      action = ''function() require("persistence").stop() end'';
      options = { desc = "Don't Save Current Session"; };
      lua = true;
    }
  ];
}
