-- See: https://github.com/lightbend/config/blob/main/HOCON.md
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.conf" },
  callback = function()
    vim.cmd("set filetype=hocon")
  end,
})
