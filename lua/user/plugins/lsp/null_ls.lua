return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local builtins = null_ls.builtins

    local formatting = builtins.formatting

    local ormolu = {
      name = "ormolu",
      method = null_ls.methods.FORMATTING,
      filetypes = { "haskell" },
      generator = null_ls.generator({
        command = "ormolu",
        args = {
          -- Add any ormolu options you want here
          -- For example: "--ghc-opt", "-XTypeApplications",
        },
        to_stdin = true,
        from_stderr = false,
        to_stdout = true,
        format = "raw",
        on_output = function(params, done)
          done(params.output)
        end,
      }),
    }

    local formatting_sources = {
      formatting.scalafmt, -- scala
      formatting.shfmt,    -- bash

      formatting.black,    -- python
      formatting.isort,    -- python sort imports

      -- formatting.markdownlint, -- markdown
      -- formatting.remark,    -- markdown

      formatting.stylua,       -- lua

      formatting.clang_format, -- C/C++/Java/JavaScript/JSON/Objective-C/Protobuf/C#
      -- formatting.codespell, -- common misspelling checker (for e.g. and instead and)
      formatting.prettierd,    -- JavaScript, TypeScript, Flow, JSX, JSON, CSS, SCSS, LESS, HTML, Vue, Angular, GraphQL, Markdown, YAML

      formatting.google_java_format,
      formatting.sqlfluff.with({
        extra_args = { "--dialect", "postgres" }, -- change to your dialect
      }),
      ormolu, -- haskell
      formatting.latexindent, -- latex
    }

    local diagnostics = builtins.diagnostics
    local diagnostics_sources = {
      diagnostics.codespell, -- common misspelling checker (for e.g. and instead and)
      -- diagnostics.cspell, -- spell checker for code
      -- diagnostics.flake8, -- python
      -- diagnostics.markdownlint, -- markdown
      -- diagnostics.misspell,  -- correct commonly misspelled words FIX:
      -- diagnostics.pyproject_flake8, -- python
      -- diagnostics.shellcheck, -- bash FIX:
      diagnostics.vale, -- Text, Markdown, LaTeX
      -- diagnostics.vulture,   -- python : find unused code
      -- diagnostics.markdownlint_cli2,
      -- diagnostics.luacheck,
      -- diagnostics.mdl,
      -- diagnostics.mypy,
      -- diagnostics.pycodestyle,
      -- diagnostics.pydocstyle,
      -- diagnostics.pylint,
      -- diagnostics.todo_comments,
      diagnostics.sqlfluff.with({
        extra_args = { "--dialect", "postgres" }, -- change to your dialect
      }),
    }

    local code_actions = builtins.code_actions
    local code_actions_sources = {
      -- code_actions.cspell,   -- spell checker for code FIX:
      code_actions.refactoring, -- automated refactoring
      -- code_actions.shellcheck, -- static analyzer for shell scripts FIX:
    }

    local sources = {}
    local addSources = function(s)
      for _, v in ipairs(s) do
        table.insert(sources, v)
      end
    end

    addSources(formatting_sources)
    addSources(diagnostics_sources)
    addSources(code_actions_sources)

    null_ls.setup({
      sources = sources,
      debug = true,
    })
  end,
}
