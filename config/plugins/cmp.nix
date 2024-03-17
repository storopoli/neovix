{
  extraConfigLuaPre = ''
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.config.setup({})
  '';

  plugins.cmp = {
    enable = true;

    settings = {
      sources = [
        { name = "copilot"; priority = 100; }
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "path"; }
      ];

      mapping = {
        __raw = ''
          cmp.mapping.preset.insert({
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
          })
        '';
      };

      snippet.expand = ''
        function(args)
        require('luasnip').lsp_expand(args.body)
        end
      '';
    };


    cmdline = {
      "/" = {
        mapping = { __raw = "cmp.mapping.preset.cmdline()"; };
        sources = [
          { name = "buffer"; }
        ];
      };

      "?" = {
        mapping = { __raw = "cmp.mapping.preset.cmdline()"; };
        sources = [
          { name = "buffer"; }
        ];
      };

      ":" = {
        mapping = {
          __raw = ''
            cmp.mapping.preset.cmdline({
              ['<S-Tab>'] = cmp.mapping.select_prev_item(),
              ['<Tab>'] = cmp.mapping.select_next_item(),
            })
          '';
        };
        sources = [
          { name = "path"; }
          { name = "cmdline"; }
        ];
      };
    };
  };

  plugins = {
    cmp-nvim-lsp.enable = true;
    cmp_luasnip.enable = true;
    luasnip.enable = true;
    cmp-path.enable = true;
    cmp-buffer.enable = true;
    cmp-git.enable = true;
  };

  extraConfigLua = ''
    require("cmp_git").setup()

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  '';
}
