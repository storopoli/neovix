{
  plugins.lazy.enable = true;

  imports = [
    ./colorscheme.nix
    ./colorizer.nix
    ./comment.nix
    ./lsp.nix
    ./telescope.nix
    ./tresitter.nix
    ./utils.nix
    ./ui.nix
    ./git.nix
  ];
}
