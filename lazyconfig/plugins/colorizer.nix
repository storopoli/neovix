{ pkgs, ... }:

{
  plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = nvim-colorizer-lua;

      config = true;
    }
  ];
}

