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
    ./telescope.nix
    ./tresitter.nix
    ./ui.nix
    ./utils.nix
  ];
}
