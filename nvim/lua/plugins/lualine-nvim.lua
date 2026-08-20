return {
  "nvim-lualine/lualine.nvim",
  optional = true,
  event = "VeryLazy",
  opts = function(_, opts)
    opts.sections.lualine_y[2] = {
      function()
        return tostring(vim.fn.line("$")) .. ":" .. tostring(vim.fn.line(".")) .. ":" .. tostring(vim.fn.col("."))
      end,
      padding = { left = 0, right = 1 },
    }
    opts.sections.lualine_z[1] = {
      function()
        return " " .. os.date("%I:%M %p")
      end,
    }

    -- do not add trouble symbols if aerial is enabled
    -- And allow it to be overriden for some buffer types (see autocmds)
    if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "lsp_document_symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        hl_group = "lualine_c_normal",
      })
      opts.sections.lualine_c[5] = {
        symbols and symbols.get,
        cond = function()
          return vim.b.trouble_lualine ~= false and symbols.has()
        end,
      }
    end
  end,
}
