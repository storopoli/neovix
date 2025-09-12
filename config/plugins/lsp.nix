{ ... }:

{
  plugins.lsp = {
    enable = true;
    keymaps.lspBuf = {
      "gd" = "definition";
      "gD" = "implementation";
      "gr" = "references";
      "gi" = "type_definition";
      "K" = "hover";
      "<leader>f" = "format";
      "<leader>r" = "rename";
      "<leader>a" = "code_action";
    };

    servers = {
      lua_ls.enable = true;
      rust_analyzer = {
        enable = true;
        packageFallback = true;
        installCargo = false;
        installRustc = false;
      };
      hls = {
        enable = true;
        packageFallback = true;
        installGhc = false;
      };
      nil_ls.enable = true;
      nixd.enable = true;
      yamlls.enable = true;
      bashls.enable = true;
      pyright.enable = true;
      ruff.enable = true;
      taplo.enable = true;
    };
  };

  # LSP diagnostic configuration
  diagnostic.settings = {
    virtual_text = false;
    virtual_lines.current_line = true;
  };
}
