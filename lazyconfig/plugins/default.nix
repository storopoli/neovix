{
  plugins.lazy.enable = true;

  imports = [
    ./colorscheme.nix
    ./colorizer.nix
    ./lsp.nix
    ./telescope.nix
    ./tresitter.nix
    ./utils.nix
    ./ui.nix
    ./git.nix
  ];
}
