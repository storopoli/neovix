{
  lib,
  ...
}:

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
      lua_ls = {
        enable = true;
        settings = {
          Lua = {
            runtime.version = "LuaJIT";
            diagnostics.globals = [
              "vim"
              "require"
            ];
            workspace = {
              library = lib.nixvim.mkRaw "vim.api.nvim_get_runtime_file('', true)";
              ignoreDir = [
                ".git"
                "node_modules"
                "target"
                "deps"
                ".cache"
                ".vscode"
                ".direnv"
                "result"
              ];
            };
            format = {
              enable = true;
              defaultConfig = {
                indent_style = "space";
                indent_size = "2";
              };
            };
            telemetry.enable = false;
          };
        };
      };
      rust_analyzer = {
        enable = true;
        packageFallback = true;
        installCargo = false;
        installRustc = false;
        settings = {
          rust-analyzer = {
            cargo.features = "all";
            procMacro = {
              enable = true;
              ignored = {
                napi-derive = [ "napi" ];
                async-recursion = [ "async_recursion" ];
                async-trait = [ "async-trait" ];
              };
            };
          };
        };
      };
      hls = {
        enable = true;
        packageFallback = true;
        installGhc = false;
        settings = {
          haskell = {
            formattingProvider = "fourmolu";
            cabalFormattingProvider = "cabal-fmt";
            plugin = {
              fourmolu.config.external = true;
              rename.config.crossModule = true;
            };
          };
        };
      };
      nil_ls = {
        enable = true;
        settings = {
          nil = {
            formatting.command = [ "nixfmt" ];
          };
        };
      };
      nixd.enable = true;
      yamlls = {
        enable = true;
        settings = {
          yaml = {
            format.enable = true;
            validation = true;
            schemas = {
              kubernetes = "*.yaml";
              "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" =
                "docker-compose.yaml";
              "https://json.schemastore.org/github-workflow.json" = ".github/workflows/*";
              "https://json.schemastore.org/github-action.json" = ".github/actions/*/action.yaml";
            };
          };
        };
      };
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
