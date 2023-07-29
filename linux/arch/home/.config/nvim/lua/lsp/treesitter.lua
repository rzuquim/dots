local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    vim.notify('Could not load treesitter! You will have a worse LSP experience.')
    return
end

treesitter.setup {
    -- 
    ensure_installed = {
        "bash",
        "c_sharp",
        "css",
        "dockerfile",
        "gitignore",
        "help",
        "html",
        "javascript",
        "json",
        "lua",
        "scss",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    -- ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- uncomment if language is buggy
        -- disable = { "c", "rust" },

        -- disabling for big files (regardless of the language)
        disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        -- disabling regex highlight since it is known to be buggy and slow
        additional_vim_regex_highlighting = false,
    },
}
