{
  plugins = {
    mini = {
      enable = true;
      modules = {
        pick = {
          mappings = {
            choose_marked = "<C-q>";
          };
        };

        surround = { }; # Default settings

        pairs = { }; # Default settings
      };

      luaConfig.post = ''
        -- Buffer picker with delete functionality
        local buffer_picker = function()
          local MiniPick = require("mini.pick")
          local wipeout_cur = function()
            vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, {})
          end
          local buffer_mappings = { wipeout = { char = "<C-d>", func = wipeout_cur } }
          MiniPick.builtin.buffers(nil, { mappings = buffer_mappings })
        end

        -- Register picker 
        local register_picker = function()
          local MiniPick = require("mini.pick")

          -- Get all registers
          local registers = {}
          local reg_names = {
            '"', "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
            "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
            "+", "*", "/", ":", ".", "%", "#", "=", "-"
          }

          for _, reg in ipairs(reg_names) do
            local content = vim.fn.getreg(reg)
            if content and content ~= "" then
              -- Truncate long content for display
              local display_content = content:gsub("\n", "\\n"):sub(1, 100)
              if #content > 100 then
                display_content = display_content .. "..."
              end
              table.insert(registers, {
                text = string.format("[%s] %s", reg, display_content),
                register = reg,
                content = content
              })
            end
          end

          local source = {
            items = registers,
            name = "Registers",
            choose = function(item)
              if item then
                -- Get the target window and paste there
                local target_win = MiniPick.get_picker_state().windows.target
                vim.api.nvim_win_call(target_win, function()
                  local lines = vim.split(item.content, "\n")
                  vim.api.nvim_put(lines, vim.fn.getregtype(item.register), true, true)
                end)
              end
            end,
            preview = function(buf_id, item)
              if item then
                local lines = vim.split(item.content, "\n")
                vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
                vim.api.nvim_set_option_value("filetype", "text", { buf = buf_id })
              end
            end
          }

          MiniPick.start({ source = source })
        end

        -- Set up keymaps for custom functions
        vim.keymap.set("n", "<leader>b", buffer_picker)
        vim.keymap.set("n", "<leader>r", register_picker)
      '';
    };

    mini-extra.enable = true;
  };

  # Custom pickers and keymaps
  keymaps = [
    {
      mode = "n";
      key = "<leader>f";
      action = "<CMD>Pick git_files<CR>";
    }
    {
      mode = "n";
      key = "<leader>F";
      action = "<CMD>Pick files<CR>";
    }
    {
      mode = "n";
      key = "<leader>/";
      action = "<CMD>Pick grep<CR>";
    }
    {
      mode = "n";
      key = "<leader>?";
      action = "<CMD>Pick help<CR>";
    }
    {
      mode = "n";
      key = "<leader>'";
      action = "<CMD>Pick resume<CR>";
    }
    {
      mode = "n";
      key = "<leader>G";
      action = "<CMD>Pick git_hunks<CR>";
    }
    {
      mode = "n";
      key = "<leader>s";
      action = ''<CMD>Pick lsp scope="document_symbol"<CR>'';
    }
    {
      mode = "n";
      key = "<leader>S";
      action = ''<CMD>Pick lsp scope="workspace_symbol"<CR>'';
    }
    {
      mode = "n";
      key = "<leader>d";
      action = ''<CMD>Pick diagnostic scope="current"<CR>'';
    }
    {
      mode = "n";
      key = "<leader>D";
      action = ''<CMD>Pick diagnostic scope="all"<CR>'';
    }
  ];

}
