return {
  "akinsho/toggleterm.nvim",
  config = function()
    local status_ok, toggleterm = pcall(require, "toggleterm")
    if not status_ok then
      print("Toggle term is not installed")
      return
    end

    toggleterm.setup({
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-t>]],
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = true, -- this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
      shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      persist_size = true,
      persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
      direction = "float",
      close_on_exit = true, -- close the terminal window when the process exits
      shell = vim.o.shell, -- change the default shell
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "curved",
        -- width = 30,
        -- height = 40,
        winblend = 3,
        highlights = {
          background = "Normal",
          border = "Normal",
        },
      },
    })

    -- TODO: setup toggle term to use lazygit and open 2 windows on the left
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<C-\\>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-w>h", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-w>j", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-w>k", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-w>l", [[<Cmd>wincmd l<CR>]], opts)
    end

    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
}
