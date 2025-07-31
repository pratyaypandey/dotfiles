return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme kanagawa-dragon")
    end,
  },
  {
    "folke/noice.nvim",
    lazy = false,
    dependencies = {
      { "MunifTanjim/nui.nvim" },
      { "rcarriga/nvim-notify" },
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      })

      vim.notify = require("notify")
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / References" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
        git = {
          ignore = false,
        },
      })
    end,
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
      { "<leader>E", "<cmd>NvimTreeFocus<cr>", desc = "Focus file explorer" },
    },
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      disabled_keys = {
        ["<Up>"] = { "n", "v", "i" },
        ["<Down>"] = { "n", "v", "i" },
        ["<Left>"] = { "n", "v", "i" },
        ["<Right>"] = { "n", "v", "i" },
      },
      disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason" },
      max_time = 1000,
      max_count = 2,
      resetting_keys = {
        ["1"] = { "n", "v" },
        ["2"] = { "n", "v" },
        ["3"] = { "n", "v" },
        ["4"] = { "n", "v" },
        ["5"] = { "n", "v" },
        ["6"] = { "n", "v" },
        ["7"] = { "n", "v" },
        ["8"] = { "n", "v" },
        ["9"] = { "n", "v" },
        ["c"] = { "n" },
        ["d"] = { "n" },
        ["x"] = { "n" },
        ["y"] = { "n" },
        ["<CR>"] = { "n" },
        ["<ESC>"] = { "n" },
      },
      restricted_keys = {
        ["h"] = { "n", "v" },
        ["j"] = { "n", "v" },
        ["k"] = { "n", "v" },
        ["l"] = { "n", "v" },
      },
      restriction_mode = "hint",
      hint = true,
      notification = true,
    },
    keys = {
      { "<leader>ht", "<cmd>Hardtime toggle<cr>", desc = "Toggle Hardtime" },
    },
  },
}