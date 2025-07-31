return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "clangd", "dockerls", "texlab" },
        automatic_installation = true,
        handlers = {
          -- Default handler for installed servers
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({ lightbulb = { enable = false } })
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup()
    end,
  },
}
