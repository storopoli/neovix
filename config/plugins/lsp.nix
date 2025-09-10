{ ... }:

{
  plugins.lsp.enable = true;

  lsp.servers = {
    # Prefer local LSP
    "*".settings.packageFallback = true;

    lua_ls.enable = true;
    rust_analyzer.enable = true;
    hls.enable = true;
    nil_ls.enable = true;
    nixd.enable = true;
    yamlls.enable = true;
    bashls.enable = true;
    pyright.enable = true;
    ruff.enable = true;
    taplo.enable = true;
  };

  # LSP diagnostic configuration
  diagnostic.settings = {
    virtual_text = false;
    virtual_lines.current_line = true;
  };
}
