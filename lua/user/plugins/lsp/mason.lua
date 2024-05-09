local buf = vim.lsp.buf
local diagnostic = vim.diagnostic

local lsp_servers = (...):match("(.-)[^%.]+$") .. "servers."
local conf = require("user.config").lsp

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({})

      -- Set virtual text support
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        { virtual_text = true }
      )
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    lazy = false,
    -- TODO: rewrite this into config function
    keys = {
      {
        "<leader>f",
        function()
          buf.format({ async = true })
        end,
      },
      { "<leader>a", buf.code_action },
      { "gd", buf.definition },
      { "gD", buf.declaration },
      { "gi", buf.implementation },
      { "K", buf.hover },
      { "gr", buf.rename },
      { "<leader>dp", diagnostic.goto_prev },
      { "<leader>dn", diagnostic.goto_next },
      { "<leader>d", diagnostic.open_float },
    },
    config = function()
      local masonlsp = require("mason-lspconfig")
      -- Fixes an issue that LSPs are sometimes not started when opening a file
      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        callback = function()
          vim.cmd("LspStart")
        end,
      })

      masonlsp.setup({
        ensure_installed = conf.ensure_installed.lsp,
        automatic_installation = true,
      })
      local attach = function(_)
        print("LSP has started")
      end

      -- Settings for LSPs
      masonlsp.setup_handlers({
        function(server_name) -- default handler
          require("lspconfig")[server_name].setup({ on_attach = attach })
        end,
        -- Server specific handlers
        ["lua_ls"] = function(_)
          require("lspconfig").lua_ls.setup(require(lsp_servers .. "lua"))
        end,
        ["pyright"] = function(_)
          local lspconfig = require("lspconfig")
          lspconfig.util.add_hook_before(lspconfig.util.on_setup, function(config)
            print("Pyright before init")
            local Path = require("plenary.path")
            local venv = Path:new((config.root_dir:gsub("/", Path.path.sep)), ".venv")

            if venv:joinpath("bin"):is_dir() then
              config.settings.python.pythonPath = tostring(venv:joinpath("bin", "python"))
              print( "Using virtual environment: " .. config.settings.python.pythonPath)
            else
              print("No virtual environment found")
            end
          end
          )
          require("lspconfig").pyright.setup({ on_attach = attach })
        end,
        ["jdtls"] = function(_)
          -- Empty function not to run it from Mason
        end,
        ["bashls"] = function(_)
          require("lspconfig").bashls.setup({
            on_attach = attach,
            filetypes = { "sh", "zsh", "zshrc" },
          })
        end,
        -- ["yamls"] = function(_)
        --   require("lspconfig").bashls.setup({
        --     settings = {
        --       yaml = {
        --         singleQuote = true,
        --       },
        --     },
        --   })
        -- end,
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    config = function()
      local masondap = require("mason-nvim-dap")
      masondap.setup({
        ensure_installed = conf.ensure_installed.dap,
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "nvimtools/none-ls.nvim",
    },
    config = function()
      local masonnull = require("mason-null-ls")
      masonnull.setup({
        ensure_installed = conf.ensure_installed.null_ls,
        automatic_installation = true,
      })
    end,
  },
}
