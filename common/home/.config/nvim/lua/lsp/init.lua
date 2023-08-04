-- making sure neovim/nvim-lspconfig is loaded
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    vim.notify("Could not require lspconfig! Language server is disabled!")
    return
end

require "lsp.mason"
require("lsp.handlers").setup()
require "lsp.null-ls"
require "lsp.treesitter"
require "lsp.autopairs"
require "lsp.emmet-ls"
require "lsp.comments"
