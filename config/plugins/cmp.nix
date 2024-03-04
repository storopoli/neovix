{
  extraConfigLuaPre = ''
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.config.setup({})
  '';

  plugins.nvim-cmp = {
    enable = true;

    sources = [
      { name = "copilot"; priority = 100; }
      { name = "nvim_lsp"; }
      { name = "luasnip"; }
      { name = "path"; }
    ];

    mapping = {
      "<C-Space>" = "cmp.mapping.complete()";
      "<C-e>" = "cmp.mapping.abort()";
      "<C-y>" = "cmp.mapping.confirm({ select = true })";
      "<C-p>" = "cmp.mapping.select_prev_item()";
      "<C-n>" = "cmp.mapping.select_next_item()";
      "<C-l>" = {
        action = ''
          function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end
        '';
        modes = [ "i" "s" ];
      };
      "<C-h>" = {
        action = ''
          function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end
        '';
        modes = [ "i" "s" ];
      };
    };

    snippet.expand = "luasnip";
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
    local cmp = require('cmp')

    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'git' },
        { name = 'path' },
      }, {
        { name = 'buffer', keyword_length = 3 },
      })
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline({
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
      }),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })

    require("cmp_git").setup()

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  '';
}
