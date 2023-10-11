-- null-ls is an adapter to communicate with linters and formatters that are not a full blown LSP
-- like prettier or es-lint
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    vim.notify("Coult not require null-ls. Linters and formatters won't be available.")
    return
end

-- list of built in formatting languages
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting

-- list of built in supported linters
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = false,
    sources = {
        formatting.prettier.with({ -- javascript
            extra_args = {
                "--no-semi",
                "--single-quote",
                "--jsx-single-quote",
            }
        }),
    },
})
