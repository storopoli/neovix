{ pkgs, ... }:

{
  plugins.surround = {
    enable = true;

    package = pkgs.vimPlugins.nvim-surround;

  };
  extraConfigLua = ''
    require("nvim-surround").setup()
  '';
}
