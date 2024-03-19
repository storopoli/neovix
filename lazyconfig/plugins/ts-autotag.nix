{ pkgs, ... }:

{
  plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = nvim-ts-autotag;

      dependencies = [ nvim-treesitter ];

      config = true;
    }
  ];
}

