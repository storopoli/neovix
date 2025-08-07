{ lib, ... }:

{
  plugins.lsp.enable = true;

  lsp = {
    inlayHints.enable = true;

    keymaps = [
      {
        key = "<leader>cr";
        lspBufAction = "rename";
      }
      {
        key = "K";
        lspBufAction = "hover";
      }
      {
        key = "gd";
        lspBufAction = "definition";
      }
      {
        key = "gr";
        lspBufAction = "references";
      }
      {
        key = "gD";
        lspBufAction = "implementation";
      }
      {
        key = "<leader>cf";
        lspBufAction = "format";
      }
      {
        key = "<leader>a";
        action = lib.nixvim.mkRaw "vim.lsp.buf.code_action";
        mode = [
          "n"
          "v"
          "x"
        ];
      }
    ];

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
        settings = {
          rust-analyzer = {
            procMacro = {
              enable = true;
              ignored = {
                napi-derive = [ "napi" ];
                async-recursion = [ "async_recursion" ];
                async-trait = null;
              };
            };
          };
        };
      };

      hls = {
        enable = true;
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

      tinymist = {
        enable = true;
        settings = {
          formatterMode = "typstyle";
        };
      };

      nixd.enable = true;
      marksman.enable = true;
      bashls.enable = true;
      fish_lsp.enable = true;
      cssls.enable = true;
      eslint.enable = true;
      html.enable = true;
      jsonls.enable = true;
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

  # LSP autogroup
  autoGroups."lsp-attach".clear = true;

  # Additional LSP configuration
  extraConfigLua = ''
    vim.cmd("set completeopt+=noselect")
  '';

  # LSP autocmds for completion and formatting
  autoCmd = [
    {
      event = "LspAttach";
      group = "lsp-attach";
      callback = lib.nixvim.mkRaw ''
        function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          -- Completion setup
          if client and client.server_capabilities.completionProvider then
            vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
            vim.keymap.set("i", "<C-n>", vim.lsp.completion.get, {
              buffer = ev.buf, noremap = true, silent = true
            })
          end

          -- Inlay hints setup
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            -- Enable by default
            vim.lsp.inlay_hint.enable(true)
            -- Toggle keymap
            vim.keymap.set("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, { buffer = ev.buf })
          end

          -- Auto format on save
          if client and client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = ev.buf,
              callback = function()
                vim.lsp.buf.format { async = false }
              end
            })
          end
        end
      '';
    }
  ];
}
