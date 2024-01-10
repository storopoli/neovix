{
  plugins.nvim-cmp = {
    enable = true;

    sources = [
      { name = "nvim_lsp"; }
      { name = "luasnip"; }
      { name = "path"; }
      { name = "buffer"; }
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

    mappingPresets = [ "cmdline" ];

    snippet.expand = "luasnip";
  };

  plugins.cmp-nvim-lsp.enable = true;
  plugins.cmp_luasnip.enable = true;
  plugins.luasnip.enable = true;
  plugins.cmp-path.enable = true;
  plugins.cmp-buffer.enable = true;
}