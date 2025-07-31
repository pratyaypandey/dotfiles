-- Bootstrap Lazy and load plugins
require("plugins")

-- Editor appearance
vim.opt.termguicolors = true
vim.cmd("colorscheme kanagawa-dragon")
vim.opt.mouse = "a"

-- Conceal LaTeX math symbols for a cleaner look
vim.opt.conceallevel = 1
vim.g.tex_conceal = "abdmg"

-- Snippet keybinds
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"

-- Save in insert and normal mode with ⌘+S
vim.keymap.set("i", "<C-s>", "<C-o>:w<CR>", { desc = "Save file from insert mode" })
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file from normal mode" })

-- Netrw file explorer improvements
vim.g.netrw_banner = 0          -- Remove banner
vim.g.netrw_liststyle = 3       -- Tree view
vim.g.netrw_browse_split = 4    -- Open in previous window
vim.g.netrw_altv = 1            -- Open splits to the right
vim.g.netrw_winsize = 25        -- Explorer width

-- Netrw keybindings
vim.keymap.set("n", "<leader>e", ":Lexplore<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>E", ":Vexplore<CR>", { desc = "Toggle vertical file explorer" })

-- Fix LaTeX line breaks - insert \\ without autocomplete
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.keymap.set("i", "<C-l>", "\\\\", { buffer = true, desc = "Insert LaTeX line break" })
  end,
})