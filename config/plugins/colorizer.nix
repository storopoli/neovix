{
  plugins.nvim-colorizer = {
    enable = true;

    fileTypes = [
      "css"
      "javascript"
      "html"
      "rust"
      "go"
    ];

    bufTypes = [
      "*"
      "!prompt"
      "!popup"
    ];

    userDefaultOptions = {
      mode = "background";

      RGB = true;
      RRGGBB = true;
      names = true;
      RRGGBBAA = false;
      rgb_fn = false;
      hsl_fn = false;
      css = true;
      css_fn = false;

      tailwind = "both";
    };
  };
}
