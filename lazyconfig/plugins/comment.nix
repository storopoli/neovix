{ pkgs, ... }:

{
  plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = comment-nvim;

      event = "VeryLazy";

      config = true;
    }
  ];
}

