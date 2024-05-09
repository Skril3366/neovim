return {
  {
    "iamcco/markdown-preview.nvim",
    event = "BufEnter *.md",
    build = "cd app && npx --yes yarn install",
    init = function()
      vim.g.mkdp_filetypes = {
        "markdown",
      }
    end,
    ft = { "markdown" },
  },
}
