{
  plugins.which-key = {
    enable = true;

    plugins.spelling.enabled = true;

    ignoreMissing = false;

    window.winblend = 5;

    registrations = {
      "<leader>c" = "+code";
      "<leader>cw" = "+workspace";
      "<leader>g" = "+git";
      "<leader>h" = "+hunks";
      "<leader>s" = "+search";
      "<leader>n" = "+noice";
      "<leader>x" = "+trouble";
    };
  };
}
