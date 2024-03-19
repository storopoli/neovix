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
    ./ts-autotag.nix
    ./ui.nix
    ./utils.nix
  ];
}
