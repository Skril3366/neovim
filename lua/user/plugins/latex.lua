return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_quickfix_ignore_filters = {
        "Underfull \\hbox",
        "Overfull \\hbox",
        "\\headheight is too small",
        "Unused",
      }
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-lualatex",
          "-shell-escape",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
    end,
    ft = { "tex" },
  },
}
