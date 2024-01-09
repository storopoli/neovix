{
  plugins.indent-blankline = {
    enable = true;

    extraOptions = {
      scope = { enabled = false; };

      exclude = {
        filetypes = [
          "help"
          "netrw"
          "Trouble"
          "lazy"
          "notify"
        ];
      };
    };
  };
}
