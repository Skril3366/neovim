return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    config = function()
      local dap = require("dap")
      local nnoremap = require("user.utils.keymap").nnoremap

      nnoremap("<leader>dc", dap.continue, "DAP continue")
      nnoremap("<leader>di", dap.step_into, "DAP step into")
      nnoremap("<leader>dO", dap.step_out, "DAP step out")
      nnoremap("<leader>do", dap.step_over, "DAP step over")

      -- Breakpoints
      local conditional_breakpoint = function()
        dap.toggle_breakpoint(vim.fn.input("Condition: "))
      end
      nnoremap(
        "<leader>dB",
        conditional_breakpoint,
        "DAP set conditional breakpoint"
      )
      nnoremap("<leader>db", dap.toggle_breakpoint, "DAP toggle breakpoint")

      -- Other
      nnoremap("<leader>dt", dap.terminate, "DAP terminate")

      dap.adapters.python = {
        type = "executable",
        command = os.getenv("HOME") .. "/.virtualenvs/tools/bin/python",
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python3",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return "/usr/local/bin/python3"
          end,
        },
      }
      -- Scala
      dap.configurations.scala = {
        {
          type = "scala",
          request = "launch",
          name = "Run",
          metals = {
            runType = "run",
          },
        },
        {
          type = "scala",
          request = "launch",
          name = "Test File",
          metals = {
            runType = "testFile",
          },
        },
        {
          type = "scala",
          request = "launch",
          name = "Test Target",
          metals = {
            runType = "testTarget",
          },
        },
      }

      -- Rust, C++ and C
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/local/opt/llvm/bin/lldb-vscode", -- adjust as needed, must be absolute path
        name = "lldb",
      }

      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input(
              "Path to executable: ",
              vim.fn.getcwd() .. "/",
              "file"
            )
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }

      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,
  },
  {
    "leoluz/nvim-dap-go",
    config = function()
      require("dap-go").setup()
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    keys = {
      { "<leader>dc", "<cmd>DapContinue<cr>", desc = "DAP continue" },
    },
    lazy = true,
    config = function()
      local dapui = require("dapui")

      local nnoremap = require("user.utils.keymap").nnoremap
      nnoremap("<leader>du", dapui.toggle, "Toggle DAP UI")

      dapui.setup({})
      local listeners = require("dap").listeners
      listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup({})
    end,
  },
}
