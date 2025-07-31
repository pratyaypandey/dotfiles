-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugin modules
local plugins = {}

-- Add all plugin modules to the plugins table
local plugin_modules = {
  "lsp",
  "latex", 
  "completion",
  "ui"
}

for _, module in ipairs(plugin_modules) do
  local module_plugins = require(module)
  if type(module_plugins) == "table" then
    for _, plugin in ipairs(module_plugins) do
      table.insert(plugins, plugin)
    end
  end
end

-- Add standalone plugins
table.insert(plugins, {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
})

-- Add conform.nvim as standalone plugin
table.insert(plugins, {
  "stevearc/conform.nvim",
  lazy = false,
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        -- LaTeX
        tex = { "latexindent" },
        
        -- Python
        python = { "isort", "black" },
        
        -- JavaScript/TypeScript
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        
        -- Web
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        
        -- Markdown
        markdown = { "prettier" },
        
        -- Lua
        lua = { "stylua" },
        
        -- Shell
        sh = { "shfmt" },
        
        -- C/C++
        c = { "clang_format" },
        cpp = { "clang_format" },
        
        -- Go
        go = { "gofmt" },
        
        -- Rust
        rust = { "rustfmt" },
      },
    })

    -- Auto-format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end,
    })
    
    -- Add Format command
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.range > 0 then
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, 0 },
        }
      end
      require("conform").format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })
    
    -- Add keybinding
    vim.keymap.set("n", "<leader>f", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, { desc = "Format buffer" })
  end,
})

require("lazy").setup(plugins)