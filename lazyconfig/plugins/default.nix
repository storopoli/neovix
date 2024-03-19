{
  plugins.lazy.enable = true;

  imports = [
    ./colorscheme.nix
    ./lsp.nix
    ./telescope.nix
    ./utils.nix
  ];
}
