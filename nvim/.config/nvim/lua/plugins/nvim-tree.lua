return function()
  require('nvim-tree').setup({
    filters = {
      custom = {
          '.git',
        -- python
        '__pycache__',
        -- latex
        '*.aux', '*.bbl', '*.blg', '*.bcf',
        '*.fdb_latexmk', '*.fls', '*.glo', '*.ist',
        '*.lof', '*.log', '*.lot', '*.synctex.gz',
        '*.toc',
      }
    }
  })
end
