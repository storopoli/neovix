{
  plugins.lazy.enable = true;

  imports = [
    ./colorscheme.nix
    ./colorizer.nix
    ./comment.nix
    ./copilot.nix
    ./format.nix
    ./git.nix
    ./lint.nix
    ./lsp.nix
    ./markdown.nix
    ./telescope.nix
    ./tresitter.nix
    ./trouble.nix
    ./ui.nix
    ./utils.nix
  ];
}
