local user_config = require("user.config")
return {
  {
    "numToStr/Comment.nvim", -- Toggle comments
    opts = {},
    lazy = false,
  },
  {
    "echasnovski/mini.trailspace",
    config = function()
      local trailspace = require("mini.trailspace")
      trailspace.setup() -- highlight and remove trailing spaces
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        callback = function()
          trailspace.trim()
          trailspace.trim_last_lines()
        end,
      })
    end,
  },
  {
    "echasnovski/mini.pairs",
    config = function()
      require("mini.pairs").setup() -- auto pair brackets and quotes
    end,
  },
  {
    "kylechui/nvim-surround", -- surround text by objects
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies =  "nvim-lua/plenary.nvim" ,
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      local nnoremap = require("user.utils.keymap").nnoremap

      nnoremap("<leader>h", function()
        harpoon:list():append()
      end, "Add file to Harpoon list")
      nnoremap("<leader>U", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, "Toggle Harpoon quick menu")
      nnoremap("<leader>n", function()
        harpoon:list():select(1)
      end, "Select Harpoon entry 1")
      nnoremap("<leader>e", function()
        harpoon:list():select(2)
      end, "Select Harpoon entry 2")
      nnoremap("<leader>i", function()
        harpoon:list():select(3)
      end, "Select Harpoon entry 3")
    end,
  },

  {
    "github/copilot.vim",
    enabled = user_config.enabled_plugins.copilot,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    config = function()
      local nnoremap = require("user.utils.keymap").nnoremap
      nnoremap("<C-w>h", [[<Cmd>TmuxNavigateLeft<CR>]])
      nnoremap("<C-w>l", [[<Cmd>TmuxNavigateRight<CR>]])
      nnoremap("<C-w>j", [[<Cmd>TmuxNavigateDown<CR>]])
      nnoremap("<C-w>k", [[<Cmd>TmuxNavigateUp<CR>]])
    end,
  },
}
