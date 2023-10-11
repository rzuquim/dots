local status_ok, terminal = pcall(require, 'toggleterm')
if not status_ok then
  vim.notify("Could not load toggleterm!")
  return
end

local shell
if IsWindows() then
  shell = 'powershell'
else
  shell =vim.o.shell
end

terminal.setup {
  size = 20,
  open_mapping = [[<C-t>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  autochdir = false,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "horizontal",
  close_on_exit = true,
  shell = shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

-- move between terminal and buffers
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)

  vim.keymap.set('n', '<M-h>', [[<Cmd>wincmd h<CR>]], opts) -- not working
  vim.keymap.set('n', '<M-j>', [[<Cmd>wincmd j<CR>]], opts) -- not working
  vim.keymap.set('n', '<M-k>', [[<Cmd>wincmd k<CR>]], opts) -- not working
  vim.keymap.set('n', '<M-l>', [[<Cmd>wincmd l<CR>]], opts) -- not working

  vim.keymap.set('t', '<M-h>', [[<Cmd>wincmd h<CR>]], opts) -- not working
  vim.keymap.set('t', '<M-j>', [[<Cmd>wincmd j<CR>]], opts) -- not working
  vim.keymap.set('t', '<M-k>', [[<Cmd>wincmd k<CR>]], opts) -- not working
  vim.keymap.set('t', '<M-l>', [[<Cmd>wincmd l<CR>]], opts) -- not working

  vim.keymap.set('n', '<leader>gg', ':lua _GitUI_Toggle()<CR>')
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal
local gitui = Terminal:new {
  cmd = "gitui",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "none",
    width = 100000,
    height = 100000,
  },
  on_open = function(_)
    vim.cmd "startinsert!"
    -- vim.cmd "set laststatus=0"
  end,
  on_close = function(_)
    -- vim.cmd "set laststatus=3"
  end,
  count = 99,
}

function _GitUI_Toggle()
  gitui:toggle()
end
