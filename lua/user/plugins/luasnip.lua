return {
  "rafamadriz/friendly-snippets", -- collection of snippets
  {
    "L3MON4D3/LuaSnip", -- snippet engine
    lazy = false,
    config = function()
      local luasnip = require("luasnip")
      local types = require("luasnip.util.types")
      local keymap = require("user.utils.keymap").keymap

      keymap({ "i", "s" }, "<C-k>", function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end, "Expand snippet or jump to the next position")

      keymap({ "i", "s" }, "<C-j>", function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, "Jump back in the snippet")

      keymap({ "i", "s" }, "<C-l>", function()
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        end
      end, "???")

      luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "<-", "Error" } },
            },
          },
        },
      })
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.snippets")
    end,
  },
}
