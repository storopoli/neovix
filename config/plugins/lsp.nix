{ pkgs, ... }:

{
  plugins.lsp = {
    enable = true;

    servers = {
      pyright = {
        enable = true;
        installLanguageServer = false;
      };
      gopls = {
        enable = true;
        installLanguageServer = false;
      };
      tsserver = {
        enable = true;
        installLanguageServer = false;
      };
      bashls = {
        enable = true;
        installLanguageServer = false;
      };
      html = {
        enable = true;
        installLanguageServer = false;
      };
      cssls = {
        enable = true;
        installLanguageServer = false;
      };
      jsonls = {
        enable = true;
        installLanguageServer = false;
      };
      eslint = {
        enable = true;
        installLanguageServer = false;
      };
      tailwindcss = {
        enable = true;
        installLanguageServer = false;
      };
      htmx = {
        enable = true;
        installLanguageServer = false;
      };
      nil_ls = {
        enable = true;
        installLanguageServer = false;
      };
      taplo = {
        enable = true;
        installLanguageServer = false;
      };
      marksman = {
        enable = true;
        installLanguageServer = false;
      };
      lua-ls = {
        enable = true;
        installLanguageServer = false;
      };
      rust-analyzer = {
        enable = true;
        installRustc = false;
        installCargo = false;
      };
      yamlls = {
        enable = true;
        installLanguageServer = false;
      };
      typst-lsp = {
        enable = true;
        installLanguageServer = false;
      };
    };

    keymaps = {
      diagnostic = {
        "[d" = "goto_prev";
        "]d" = "goto_next";
        "<leader>e" = "open_float";
        "<leader>k" = "setloclist";
      };

      lspBuf = {
        "<leader>cr" = "rename";
        "<leader>ca" = "code_action";
        "gd" = "definition";
        "gi" = "implementation";
        "K" = "hover";
        "gS" = "signature_help";
        "gD" = "declaration";
        "<leader>D" = "type_definition";
      };
    };
  };

  plugins.which-key.registrations = {
    "[d" = "Previous [D]iagnostics";
    "]d" = "Next [D]iagnostics";
    "<leader>e" = "[D]iagnostics: Op[e]n Float";
    "<leader>k" = "[D]iagnostics: List";
    "<leader>cr" = "[R]ename";
    "<leader>ca" = "Code [A]ction";
    "gd" = "[G]oto [D]efinition";
    "gi" = "[G]oto [I]mplementation";
    "K" = "Hover Documentation";
    "gS" = "[S]ignature Documentation";
    "gD" = "[G]oto [D]eclaration";
    "<leader>D" = "Type [D]efinition";
  };

  keymaps = [
    {
      mode = "n";
      key = "gr";
      action = ''require("telescope.builtin").lsp_references'';
      options = { desc = "[R]eferences"; };
      lua = true;
    }
    {
      mode = "n";
      key = "<leader>sD";
      action = ''require("telescope.builtin").lsp_document_symbols'';
      options = { desc = "[D]ocument [S]symbols"; };
      lua = true;
    }
    {
      mode = "n";
      key = "<leader>sy";
      action = ''require("telescope.builtin").lsp_dynamic_workspace_symbols'';
      options = { desc = "S[y]mbols"; };
      lua = true;
    }
  ];

  plugins.fidget = {
    enable = true;

    notification.window.winblend = 0;
  };

  extraPackages = with pkgs; [
    nodePackages_latest.bash-language-server
    nodePackages_latest.typescript-language-server
    rust-analyzer
    gopls
    vscode-langservers-extracted
    tailwindcss-language-server
    # htmx-lsp #FIXME: broken in darwin-aarch64
    pyright
    lua-language-server
    nil
    taplo
    yaml-language-server
    marksman
    typst-lsp
  ];
}
