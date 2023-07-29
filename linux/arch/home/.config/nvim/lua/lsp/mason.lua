local mason_status_ok, mason = pcall(require, "mason")
local mason_lsp_status_ok, mason_lsp = pcall(require, "mason-lspconfig")
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
local lsp_handlers_status_ok, lsp_handlers = pcall(require, "lsp.handlers")

local ok =
    mason_status_ok and
    mason_lsp_status_ok and
    lspconfig_status_ok and
    lsp_handlers_status_ok

if not ok then
    vim.notify(
        "Could not require mason!" ..
        " mason: " ..  mason_status_ok ..
        " mason_lsp: " .. mason_lsp_status_ok ..
        " lspconfig: " .. lspconfig_status_ok ..
        " lsp_handlers: " .. lsp_handlers_status_ok
    )
    return
end

-- options available in https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local servers = {
    "bashls",
    "cssls",
    "cucumber_language_server",
    "dockerls",
    "eslint",
    "hls", -- haskell (requires ghcup-hs-bin)
    "html",
    "jsonls",
    "lemminx", -- xml
    "marksman", -- markdown
    "omnisharp", -- csharp
    "sqlls",
    "lua_ls",
    "taplo", -- toml
    "tsserver",
    "yamlls",
}

local settings = {
    ui = { -- configuring mason window appearance
        border = "none",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
    PATH = 'prepend',
}

mason.setup(settings)
mason_lsp.setup({
    ensure_installed = servers,
    automatic_installation = true,
})

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = lsp_handlers.on_attach,
        capabilities = lsp_handlers.capabilities,
    }

    server = vim.split(server, "@")[1]

    -- loading specific lsp configuration based on the the name convention
    local config_path = "lsp.settings." .. server
    local has_lsp_specific_conf, lsp_specific_conf = pcall(require, config_path)
    if has_lsp_specific_conf then
        opts = vim.tbl_deep_extend("force", lsp_specific_conf, opts)
    end

    lspconfig[server].setup(opts)
end
