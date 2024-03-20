{ pkgs, ... }:

{
  plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = nvim-lspconfig;

      event = [ "BufReadPre" "BufNewFile" ];

      dependencies = [
        cmp-nvim-lsp # LSP source for nvim-cmp
        nvim-cmp # Autocompletion plugin
        cmp-buffer # nvim-cmp source for buffer words
        cmp-path # nvim-cmp source for filesystem paths
        cmp-nvim-lua # nvim-cmp source for neovim Lua API
        cmp_luasnip # Snippets source for nvim-cmp
        luasnip # Snippets plugin
        cmp-git # nvim-cmp source for git
        copilot-cmp # nvim-cmp for copilot
      ];

      config = ''
        function()
          local lsp = require("lspconfig")
          -- Global mappings.
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [D]iagnostics" })
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next [D]iagnostics" })
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "[D]iagnostics: Op[e]n Float" })
          vim.keymap.set("n", "<leader>k", vim.diagnostic.setloclist, { desc = "[D]iagnostics: List" })
          -- Use LspAttach autocommand to only map the following keys
          -- after the language server attaches to the current buffer
          vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
              -- Buffer local mappings.
              -- Code Actions
              vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[R]ename", buffer = ev.buf })
              vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code [A]ction", buffer = ev.buf })
              -- Definitions
              vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition", buffer = ev.buf })
              vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation", buffer = ev.buf })
              vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "[R]eferences" })
              vim.keymap.set(
                "n",
                "<leader>sD",
                require("telescope.builtin").lsp_document_symbols,
                { desc = "[D]ocument [S]symbols", buffer = ev.buf }
              )
              vim.keymap.set(
                "n",
                "<leader>sy",
                require("telescope.builtin").lsp_dynamic_workspace_symbols,
                { desc = "S[y]mbols", buffer = ev.buf }
              )
              -- See `:help K` for why this keymap
              vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation", buffer = ev.buf })
              vim.keymap.set("n", "gS", vim.lsp.buf.signature_help, { desc = "[S]ignature Documentation", buffer = ev.buf })
              -- Lesser used LSP functionality
              vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration", buffer = ev.buf })
              vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type [D]efinition", buffer = ev.buf })
            end,
          })
          -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
          -- Add additional capabilities supported by nvim-cmp
          local capabilities = require("cmp_nvim_lsp").default_capabilities()
          capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
          -- luasnip setup
          local luasnip = require("luasnip")
          require("luasnip.loaders.from_vscode").lazy_load()
          luasnip.config.setup({})
          -- cmp setup
          local cmp = require("cmp")
          cmp.setup({
            completion = {
              completeopt = "menu,menuone,noinsert",
            },
            snippet = {
              expand = function(args)
                luasnip.lsp_expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert({
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<C-e>"] = cmp.mapping.abort(),
              ["<C-n>"] = cmp.mapping.select_next_item(),
              ["<C-p>"] = cmp.mapping.select_prev_item(),
              ["<C-y>"] = cmp.mapping.confirm({ select = true }),
              ["<C-l>"] = cmp.mapping(function()
                if luasnip.expand_or_locally_jumpable() then
                  luasnip.expand_or_jump()
                end
              end, { "i", "s" }),
              ["<C-h>"] = cmp.mapping(function()
                if luasnip.locally_jumpable(-1) then
                  luasnip.jump(-1)
                end
              end, { "i", "s" }),
            }),
            sources = {
              { name = "copilot", priority = 100 },
              { name = "nvim_lsp" },
              { name = "luasnip" },
              { name = "path" },
            },
          })

          -- Set configuration for specific filetype.
          cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
              { name = "git" },
              { name = "path" },
            }, {
              { name = "buffer", keyword_length = 3 },
            }),
          })

          -- Use buffer source for `/` and `?`
          cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
              { name = "buffer" },
            },
          })

          -- Use path and cmdline source for `:` with TAB/Shift-TAB as autocomplete
          cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline({
              ["<S-Tab>"] = cmp.mapping.select_prev_item(),
              ["<Tab>"] = cmp.mapping.select_next_item(),
            }),
            sources = cmp.config.sources({
              { name = "path" },
            }, {
              { name = "cmdline" },
            }),
          })

          require("cmp_git").setup()

          -- If you want insert `(` after select function or method item
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

          -- LSPs
          lsp.pyright.setup({ -- requires pyright to be installed
            capabilities = capabilities,
            settings = {
              pyright = {
                -- Using Ruff's import organizer
                disableOrganizeImports = true,
              },
            },
          })
          lsp.ruff_lsp.setup({ -- requires ruff-lsp to be installed
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end,
          })
          lsp.gopls.setup({ capabilities = capabilities }) -- requires gopls to be installed
          lsp.tsserver.setup({ capabilities = capabilities }) -- requires typescript-language-server to be installed
          lsp.bashls.setup({ capabilities = capabilities }) -- requires bash-language-server to be installed
          lsp.html.setup({ capabilities = capabilities }) -- requires vscode-langservers-extracted to be installed
          lsp.cssls.setup({ capabilities = capabilities }) -- requires vscode-langservers-extracted to be installed
          lsp.jsonls.setup({ capabilities = capabilities }) -- requires vscode-langservers-extracted to be installed
          lsp.julials.setup({ capabilities = capabilities }) -- requires julia to be installed
          lsp.eslint.setup({ capabilities = capabilities }) -- requires vscode-langservers-extracted to be installed
          lsp.nil_ls.setup({ capabilities = capabilities }) -- requires nil-lsp to be installed
          lsp.taplo.setup({ capabilities = capabilities }) -- requires taplo to be installed
          lsp.marksman.setup({ capabilities = capabilities }) -- requires marksman to be installed
          lsp.julials.setup({ capabilities = capabilities }) -- requires julia to be installed
          lsp.lua_ls.setup({ -- requires lua-language-server to be installed
            capabilities = capabilities,
            settings = {
              Lua = {
                telemetry = { enable = false },
                hint = { enable = true },
                workspace = {
                  checkThirdParty = false,
                  -- Tells lua_ls where to find all the Lua files that you have loaded
                  -- for your neovim configuration.
                  library = {
                    "$${3rd}/luv/library",
                    unpack(vim.api.nvim_get_runtime_file("", true)),
                  },
                  ignoreDir = {
                    ".direnv",
                  },
                },
                completion = {
                  callSnippet = "Replace",
                },
                diagnostics = {
                  globals = { "vim" },
                  disable = { "missing-fields" },
                },
              },
            },
          })
          lsp.rust_analyzer.setup({ -- requires rust-analyzer to be installed
            capabilities = capabilities,
            settings = {
              ['rust-analyzer'] = {
                check = {
                  command = "clippy",
                },
                imports = {
                    granularity = {
                      group = "module",
                    },
                },
                files = {
                  excludeDirs = {
                    ".direnv",
                    ".git",
                    "target",
                    "js",
                    "node_modules",
                    "assets",
                  },
                },
              },
            },
          })
          lsp.yamlls.setup({ -- requires yaml-language-server to be installed
            capabilities = capabilities,
            settings = {
              yamlls = {
                schemas = {
                  ["https=//raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.yaml",
                  ["https=//json.schemastore.org/github-workflow.json"] = ".github/workflows/*.yaml",
                  ["https=//json.schemastore.org/github-action.json"] = ".github/actions/*/action.yaml",
                },
              },
            },
          })
          lsp.typst_lsp.setup({ capabilities = capabilities }) -- requires typst-lsp to be installed
        end
      '';
    }
  ];

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
