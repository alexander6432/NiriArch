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

      opts.sections.lualine_c[4] = {
        function()
          local filepath = vim.fn.expand("%:p")

          if filepath == "" then
            return "[No Name]"
          end

          local cwd = vim.fn.getcwd()
          if cwd:sub(-1) ~= "/" then
            cwd = cwd .. "/"
          end

          local display_path
          local relative = filepath:sub(1, #cwd) == cwd
          if relative then
            display_path = filepath:sub(#cwd + 1)
          else
            display_path = vim.fn.fnamemodify(filepath, ":~")
          end

          local dir = display_path:match("(.*)/[^/]+$") or ""
          local filename = display_path:match("([^/]+)$") or display_path

          local prefix = ""
          if not relative then
            if dir:sub(1, 1) == "~" then
              prefix = "~/"
              dir = dir:sub(3)
            elseif dir:sub(1, 1) == "/" then
              prefix = "/"
              dir = dir:sub(2)
            end
          end

          local parts = {}
          for part in dir:gmatch("[^/]+") do
            table.insert(parts, part)
          end

          local n = #parts
          for i, part in ipairs(parts) do
            if i == n then
            elseif i == n - 1 then
              if #part > 6 then
                parts[i] = part:sub(1, 3) .. "…"
              end
            else
              if #part > 4 then
                parts[i] = part:sub(1, 1) .. "…"
              end
            end
          end

          local shortened_dir = table.concat(parts, "/")
          local shortened_path = prefix .. shortened_dir
          if shortened_dir ~= "" then
            shortened_path = shortened_path .. "/"
          end
          shortened_path = shortened_path .. filename

          if vim.fn.filereadable(filepath) == 0 then
            return shortened_path .. " [N]"
          end

          local symbol = ""
          if vim.bo.modified then
            symbol = " [M]"
          elseif vim.bo.readonly then
            symbol = " [R]"
          end

          return shortened_path .. symbol
        end,
      }
    end
  end,
}
