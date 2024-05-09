local vault_path = os.getenv("HOME") .. "/Vault/Obsidian/Vault"

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  event = {
    "BufReadPre " .. vault_path .. "/**.md",
    "BufNewFile " .. vault_path .. "/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "Vault",
        path = vault_path,
      },
    },
    daily_notes = {
      folder = "100 Journal/01 Daily Notes",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
    },
  },
}
