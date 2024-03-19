{ pkgs, ... }:

{
  plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = markdown-preview-nvim;

      ft = [ "markdown" ];

      event = "VeryLazy";

      cmd = [ "MarkdownPreviewToggle" "MarkdownPreview" "MarkdownPreviewStop" ];

      init = ''
        function()
          vim.g.mkdp_filetypes = { "markdown" }
        end
      '';

      keys = {
        __raw = ''
          {
            { "<leader>m", "<CMD>MarkdownPreview<CR>", desc = "[M]arkdown Preview" },
          }
        '';
      };
    }
  ];

}

