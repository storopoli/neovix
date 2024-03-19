{ pkgs, ... }:

{
  plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = nvim-autopairs; # Autopair stuff like ({["'

      config = true;
    }

    {
      pkg = nvim-surround; # Surround selections

      dependencies = [ nvim-treesitter ];

      config = true;
    }
  ];
}
