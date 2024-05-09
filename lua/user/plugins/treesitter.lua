return {
  {
    "David-Kunz/markid",
    config = function()
      local markid = require("markid")

      local markid_colors = {
        medium = {
          "#2ac3de",
          "#73daca",
          "#7aa2f7",
          "#7dcfff",
          "#b4f9f8",
          "#bb9af7",
          "#e0af68",
          "#f7768e",
          "#ff9e64",
        },
      }
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        markid = {
          enable = true,
          colors = markid_colors.medium,
          queries = markid.queries,
          is_supported = function(lang)
            local queries = configs.get_module("markid").queries
            return pcall(
              vim.treesitter.query.parse,
              lang,
              queries[lang] or queries["default"]
            )
          end,
        },
      })
    end,
  }, -- highlight same identifiers with the same color
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    config = function()
      vim.opt.runtimepath:append("$HOME/.local/share/treesitter") -- fixes issue with reinstalling parsers every time nvim is opened, see https://github.com/nvim-treesitter/nvim-treesitter/issues/3605
      -- vim.api.nvim_create_autocmd({ "BufEnter" }, { pattern = { "*" }, command = "normal zx" }) -- fixes folding

      require("nvim-treesitter.configs").setup({
        parser_install_dir = "$HOME/.local/share/treesitter",
        ensure_installed = {
          "cpp",
          "c",
          "lua",
          "go",
          "scala",
          "rust",
          -- Scripting languages
          "bash",
          -- Markup languages
          "yaml",
          "latex",
          "json",
          "markdown",
          "org",
          "hocon",
          -- git
          "gitcommit",
          "gitignore",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        indent = {
          enable = true,
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "org" }, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
        },
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
        refactor = {
          highlight_definitions = {
            enable = true,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = true,
          },
          highlight_current_scope = { enable = true },
          navigation = {
            enable = false,
          },
        },
        rainbow = {
          enable = true,
          -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
          -- colors = {}, -- table of hex strings
          -- termcolors = {} -- table of colour name strings
        },
      })
    end,
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter-context",
  --   config = function()
  --     require("treesitter-context").setup({
  --       enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  --       max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
  --       trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  --       min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  --       patterns = {
  --         -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
  --         -- For all filetypes
  --         -- Note that setting an entry here replaces all other patterns for this entry.
  --         -- By setting the 'default' entry below, you can control which nodes you want to
  --         -- appear in the context window.
  --         default = {
  --           "class",
  --           "function",
  --           "method",
  --           "for",
  --           "while",
  --           "if",
  --           "switch",
  --           "case",
  --         },
  --         -- Patterns for specific filetypes
  --         -- If a pattern is missing, *open a PR* so everyone can benefit.
  --         tex = {
  --           "chapter",
  --           "section",
  --           "subsection",
  --           "subsubsection",
  --         },
  --         rust = {
  --           "impl_item",
  --           "struct",
  --           "enum",
  --         },
  --         scala = {
  --           "object_definition",
  --         },
  --         vhdl = {
  --           "process_statement",
  --           "architecture_body",
  --           "entity_declaration",
  --         },
  --         markdown = {
  --           "section",
  --         },
  --         elixir = {
  --           "anonymous_function",
  --           "arguments",
  --           "block",
  --           "do_block",
  --           "list",
  --           "map",
  --           "tuple",
  --           "quoted_content",
  --         },
  --         json = {
  --           "pair",
  --         },
  --         yaml = {
  --           "block_mapping_pair",
  --         },
  --       },
  --       exact_patterns = {
  --         -- Example for a specific filetype with Lua patterns
  --         -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
  --         -- exactly match "impl_item" only)
  --         -- rust = true,
  --       },
  --       -- [!] The options below are exposed but shouldn't require your attention,
  --       --     you can safely ignore them.
  --
  --       zindex = 20, -- The Z-index of the context window
  --       mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
  --       -- Separator between context and content. Should be a single character string, like '-'.
  --       -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  --       separator = nil,
  --       markid = { enable = true },
  --     })
  --   end,
  -- }, -- Show current context as top line
  {
    "nvim-treesitter/nvim-treesitter-refactor",
    config = function() end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function() end,
  },
  {
    "nvim-treesitter/playground",
    config = function() end,
  }, -- TS information viewer
  {
    "hiphish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup()
    end,
  },
  -- {
  --   "p00f/nvim-ts-rainbow",
  --   config = function() end,
  -- }, -- Rainbow parentheses
  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup()
    end,
  }, -- highlighting arguments of functions
}
