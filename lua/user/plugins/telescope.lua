return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")
      local nnoremap = require("user.utils.keymap").nnoremap

      local find_files_default_opts = {
        hidden = true,
        no_ignore = true,
      }

      local show_nvim_config_files = function()
        builtin.find_files(vim.tbl_extend("force", {
          cwd = os.getenv("HOME") .. "/.config/nvim",
          file_ignore_patterns = { ".git", "undodir" },
        }, find_files_default_opts))
      end
      nnoremap(
        "<leader>m",
        show_nvim_config_files,
        "Show files in $HOME/.config/nvim"
      )

      nnoremap(
        "<leader>o",
        builtin.find_files,
        "Search files in the current working directory"
      )
      nnoremap("<leader>.", function()
        builtin.find_files(vim.tbl_extend("force", {}, find_files_default_opts))
      end, "Search files in the current working directory")
      nnoremap(
        "<leader>gf",
        builtin.git_files,
        "Search files in the current git repository"
      )
      -- Git
      nnoremap(
        "<leader>gc",
        builtin.git_bcommits,
        "Search git commits for current buffer"
      )
      nnoremap("<leader>gC", builtin.git_bcommits, "Search all git commits")
      nnoremap("<leader>gb", builtin.git_branches, "Search git branches")

      -- Inside files
      nnoremap(
        "<leader>s",
        builtin.current_buffer_fuzzy_find,
        "Fuzzy find in the current buffer"
      )
      nnoremap(
        "<leader>gg",
        builtin.live_grep,
        "Grep in all the files in current working directory"
      )

      -- LSP
      nnoremap(
        "<leader>w",
        builtin.lsp_document_symbols,
        "Search lsp symbols in the current file"
      )
      nnoremap(
        "<leader>W",
        builtin.lsp_dynamic_workspace_symbols,
        "Search lsp symbols in the project"
      )
      nnoremap(
        "gR",
        builtin.lsp_references,
        "Show all references of the symbol under the cursor"
      )

      -- Help
      nnoremap("<leader>H", builtin.help_tags, "Search nvim documentation")
      nnoremap("<leader>K", builtin.keymaps, "Search all current keymaps")

      -- Other
      nnoremap("<leader>D", function()
        builtin.diagnostics({ severity_limit = "warn" })
      end, "Show all the diagnostics messages in the project")
      nnoremap("<leader>b", builtin.buffers, "Show all opened buffers")
      nnoremap("<leader>q", builtin.quickfix, "Show current quickfix list")
      nnoremap("<leader>r", builtin.resume, "Show last search")

      nnoremap("<leader>*", function()
        builtin.grep_string({
          search = vim.fn.expand("<cword>"),
          word_match = "-w",
        })
      end, "Search the word under the cursor")

      telescope.setup({
        defaults = {
          -- TODO: see https://github.com/nvim-telescope/telescope.nvim/issues/623
          -- preview = {
          --   filesize_hook = function(filepath, bufnr, opts)
          --     local max_bytes = 10000
          --     local cmd = { "head", "-c", max_bytes, filepath }
          --     require("telescope.previewers.utils").job_maker(cmd, bufnr, opts)
          --   end,
          -- },
          file_ignore_patterns = { ".git" },
          prompt_prefix = "",
          vimgrep_arguments = {
            "rg", -- requires ripgrep to be installed (for e.g. `brew install ripgrep`)
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim", -- add this value
          },
          mappings = {
            n = {
              ["<C-d>"] = actions.delete_buffer,
            },
            i = {
              ["<C-f>"] = actions.to_fuzzy_refine,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-d>"] = actions.remove_selection,
              ["<C-j>"] = actions.move_selection_previous,
              ["<C-k>"] = actions.move_selection_next,
              -- ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-h>"] = "which_key",
              ["<C-q>"] = function(bufnr)
                actions.smart_send_to_qflist(bufnr)
                builtin.quickfix()
              end,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }, -- requires fd to be installed (for e.g. `brew install fd`)
          },
          current_buffer_fuzzy_find = {
            theme = "cursor",
          },
        },
      })
    end,
  }, -- Highly exendable fuzzy finder over lists
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("telescope").load_extension("dap")
    end,
  },
  -- TODO: uncomment
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      telescope.load_extension("fzf")
    end,
  }, -- Sorter for telescope to improve performance
  {
    "ahmedkhalf/project.nvim",
    keys = {
      {
        "<leader>p",
        "<cmd>Telescope projects<cr>",
        desc = "Show all the projects",
      },
    },
    lazy = false,
    config = function()
      require("telescope").load_extension("projects")
      require("project_nvim").setup({
        manual_mode = false,
        detection_methods = { "lsp", "pattern" },
        patterns = {
          ".metals",
          ".git",
          "=tex",
          -- "_darcs",
          -- ".hg",
          -- ".bzr",
          -- ".svn",
          "Makefile",
          -- "package.json",
        },
        exclude_dirs = { os.getenv("HOME") },
        show_hidden = false,
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        silent_chdir = true,
        scope_chdir = "global",
      })
    end,
  },
}
