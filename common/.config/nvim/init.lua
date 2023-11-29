function IsWindows()
  local os = vim.loop.os_uname().sysname
  return os == 'Windows_NT'
end

function IsDiff()
  return vim.api.nvim_win_get_option(0, "diff")
end

vim.cmd('source ~/.vimrc')

require "options"
require "keymaps"
require "plugins"
require "search"
require "lsp"
require "appearance"
require "behavior"

