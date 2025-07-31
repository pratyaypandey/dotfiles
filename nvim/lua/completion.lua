return {
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "ultisnips" },
        },
      })
    end,
  },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-path" },
  { "quangnguyen30192/cmp-nvim-ultisnips" },
  { "sirver/ultisnips" },
}
