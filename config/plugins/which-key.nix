{
  plugins.which-key = {
    enable = true;

    plugins.spelling.enabled = true;

    ignoreMissing = false;

    window.winblend = 5;

    registrations = {
      "g" = { name = "+goto"; _ = "which_key_ignore"; };
      "]" = { name = "+next"; _ = "which_key_ignore"; };
      "[" = { name = "+prev"; _ = "which_key_ignore"; };
      "<leader>c" = { name = "+code"; _ = "which_key_ignore"; };
      "<leader>cw" = { name = "+workspace"; _ = "which_key_ignore"; };
      "<leader>g" = { name = "+git"; _ = "which_key_ignore"; };
      "<leader>h" = { name = "+hunks"; _ = "which_key_ignore"; };
      "<leader>s" = { name = "+search"; _ = "which_key_ignore"; };
      "<leader>n" = { name = "+noice"; _ = "which_key_ignore"; };
      "<leader>x" = { name = "+trouble"; _ = "which_key_ignore"; };
      "<leader>t" = { name = "+session"; _ = "which_key_ignore"; };
    };
  };
}
