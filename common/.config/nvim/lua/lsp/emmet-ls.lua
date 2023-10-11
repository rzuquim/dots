-- depends on the server installed on the machine `npm install -g emmet-ls`
local lsp_ok, lspconfig = pcall(require, 'lspconfig')
local lsp_configs_ok, configs = pcall(require, 'lspconfig/configs')

if not lsp_ok or not lsp_configs_ok then
    vim.notify("Could not require LSP to setup emmet.")
    return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.emmet_ls.setup {
    -- on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
        'html',
        'typescriptreact',
        'javascriptreact',
        'css',
        'sass',
        'scss',
        'less',
    },
    init_options = {
        html = {
            options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ["bem.enabled"] = true,
            },
        },
    }
}
