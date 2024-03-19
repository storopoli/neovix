{
  plugins.lazy.enable = true;

  imports = [
    ./colorscheme.nix
    ./colorizer.nix
    ./comment.nix
    ./copilot.nix
    ./git.nix
    ./lsp.nix
    ./telescope.nix
    ./tresitter.nix
    ./ui.nix
    ./utils.nix
  ];
}
