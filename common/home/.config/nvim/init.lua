function IsWindows()
  local os = vim.loop.os_uname().sysname
  return os == 'Windows_NT'
end

require "options"
require "keymaps"
require "plugins"
require "search"
require "lsp"
require "appearance"
require "behavior"

