return {
  {
    "lervag/vimtex",
    init = function()
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_view_method = "general"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        continuous = 1,
        options = {
          "-pdf", "-pvc", "-interaction=nonstopmode", "-synctex=1", "-shell-escape"
        }
      }

      -- Function to clean up all auxiliary files
      local function cleanup_tex_files(tex_file)
        if not tex_file then return end
        
        -- Get the base name without extension
        local base_name = tex_file:gsub("%.tex$", "")
        local dir = vim.fn.fnamemodify(tex_file, ":h")
        
        -- List of common LaTeX auxiliary files to remove
        local aux_files = {
          ".aux", ".log", ".out", ".toc", ".lof", ".lot", ".fls", ".fdb_latexmk",
          ".synctex.gz", ".bbl", ".blg", ".bcf", ".run.xml", ".nav", ".snm",
          ".vrb", ".xdv", ".dvi", ".pdf", "indent.log"  -- Including PDF and indent.log!
        }
        
        -- Remove each auxiliary file if it exists
        for _, ext in ipairs(aux_files) do
          local aux_file = base_name .. ext
          if vim.fn.filereadable(aux_file) == 1 then
            vim.fn.delete(aux_file)
            print("Cleaned up: " .. aux_file)
          end
        end
        
        -- Also clean up any files in the same directory with the same base name
        -- but different extensions (for more thorough cleanup)
        local files = vim.fn.glob(dir .. "/" .. vim.fn.fnamemodify(base_name, ":t") .. ".*")
        for file in files:gmatch("[^\n]+") do
          local ext = vim.fn.fnamemodify(file, ":e")
          if ext ~= "tex" and vim.fn.filereadable(file) == 1 then
            vim.fn.delete(file)
            print("Cleaned up: " .. file)
          end
        end
      end

      vim.api.nvim_create_autocmd("BufUnload", {
        pattern = "*.tex",
        callback = function(args)
          cleanup_tex_files(args.file)
        end,
      })
    end,
  },
}
