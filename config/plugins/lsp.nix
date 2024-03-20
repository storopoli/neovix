{ pkgs, ... }:

{
  plugins.lsp = {
    enable = true;

    servers = {
      pyright = {
        enable = true;
        package = null;
        extraOptions = {
          settings = {
            pyright = {
              # Using Ruff's import organizer
              disableOrganizeImports = true;
            };
          };
        };
      };
      ruff-lsp = {
        enable = true;
        package = null;
        extraOptions = {
          # Disable hover in favor of pyright.
          on_attach.__raw = ''
            function(client, bufnr)
              if client.name == "ruff_lsp" then
                client.server_capabilities.hoverProvider = false
              end
            end
          '';
        };
      };
      gopls = {
        enable = true;
        package = null;
      };
      tsserver = {
        enable = true;
        package = null;
      };
      julials = {
        enable = true;
        package = null;
      };
      bashls = {
        enable = true;
        package = null;
      };
      html = {
        enable = true;
        package = null;
      };
      cssls = {
        enable = true;
        package = null;
      };
      jsonls = {
        enable = true;
        package = null;
      };
      eslint = {
        enable = true;
        package = null;
      };
      nil_ls = {
        enable = true;
        package = null;
      };
      taplo = {
        enable = true;
        package = null;
      };
      marksman = {
        enable = true;
        package = null;
      };
      lua-ls = {
        enable = true;
        package = null;
        extraOptions = {
          Lua = {
            telemetry = { enable = false; };
            hint = { enable = true; };
            workspace = {
              checkThirdParty = false;
              ignoreDir = [
                ".direnv"
              ];
            };
            completion = {
              callSnippet = "Replace";
            };
            diagnostics = {
              globals = [ "vim" ];
              disable = [ "missing-fields" ];
            };
          };
        };
      };
      rust-analyzer = {
        enable = true;
        package = null;
        installRustc = false;
        installCargo = false;
        settings = {
          check = {
            command = "clippy";
          };
          imports = {
            granularity = {
              group = "module";
            };
          };
          files = {
            excludeDirs = [
              ".direnv"
              ".git"
              "target"
              "js"
              "node_modules"
              "assets"
            ];
          };
        };
      };
      yamlls = {
        enable = true;
        package = null;
        extraOptions = {
          yamlls = {
            schemas = {
              "https=//raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" = "docker-compose.yaml";
              "https=//json.schemastore.org/github-workflow.json" = ".github/workflows/*.yaml";
              "https=//json.schemastore.org/github-action.json" = ".github/actions/*/action.yaml";
            };
          };
        };
      };
      typst-lsp = {
        enable = true;
        package = null;
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
    pyright
    ruff-lsp
    lua-language-server
    nil
    taplo
    yaml-language-server
    marksman
    typst-lsp
  ];
}
