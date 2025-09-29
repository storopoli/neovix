{
  lib,
  ...
}:

{
  plugins = {
    copilot-lua = {
      enable = true;
      settings = {
        filetypes = {
          markdown = true; # overrides default
          sh = lib.nixvim.mkRaw ''
            function()
              if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
                -- disable for .env files
                return false
              end
              return true
            end
          '';
        };
      };
    };
  };
}
