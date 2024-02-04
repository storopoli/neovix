{
  plugins.nvim-cmp = {
    enable = true;

    sources = [
      { name = "nvim_lsp"; }
      { name = "luasnip"; }
      { name = "path"; }
      { name = "buffer"; }
      { name = "copilot"; }
    ];

    mapping = {
      "<C-b>" = "cmp.mapping.scroll_docs(-4)";
      "<C-f>" = "cmp.mapping.scroll_docs(4)";
      "<C-Space>" = "cmp.mapping.complete()";
      "<C-e>" = "cmp.mapping.abort()";
      "<CR>" = "cmp.mapping.confirm({ select = true })";
      "<C-p>" = {
        action = "cmp.mapping.select_prev_item()";
        modes = [ "i" "s" ];
      };
      "<C-n>" = {
        action = "cmp.mapping.select_next_item()";
        modes = [ "i" "s" ];
      };
      "<Tab>" = {
        action = ''
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_locally_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end
        '';
        modes = [ "i" "s" ];
      };
      "<S-Tab>" = {
        action = ''
          function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
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
