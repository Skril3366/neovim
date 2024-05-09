local should_set_up_rust = require("user.config").lsp.additionally_set_up.rust

if should_set_up_rust then
  return {
    "simrat39/rust-tools.nvim",
    event = "BufEnter *.rs, Cargo.toml",
    init = function() end,
    config = function()
      local rt = require("rust-tools")
      rt.setup({
        server = {
          on_attach = function(_, bufnr)
            rt.inlay_hints.enable()
            -- Hover actions
            -- vim.keymap.set("n", "<Leader>A", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            -- vim.keymap.set("n", "<Leader>A", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      })
    end,
  }
end
