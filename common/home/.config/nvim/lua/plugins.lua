local fn = vim.fn

-- automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- autocommand that reloads neovim whenever you save the plugins.lua file (this file)
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("Could not require packer! Plugins are disabled!")
    return
end

-- have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- plugins are just github repositories <user>/<repo>
local plugins = {
    "wbthomason/packer.nvim", -- packer manage itself
    "nvim-lua/popup.nvim", -- implementation of the Popup API from vim in Neovim
    "nvim-lua/plenary.nvim", -- useful lua util functions used in lots of plugins
    "Pocco81/auto-save.nvim", -- auto saves file
    "folke/which-key.nvim", -- leader keybinding help

    -- text manipulation
    'sQVe/sort.nvim', -- sort selection
    'tpope/vim-surround', -- surrond selection S
    'arthurxavierx/vim-caser', -- change word case
    'mg979/vim-visual-multi', -- multi-cursor

    -- auto-complete
    "hrsh7th/nvim-cmp", -- the completion plugin
    "hrsh7th/cmp-buffer", -- buffer completions (text from the current open file)
    "hrsh7th/cmp-path", -- path completions
    "hrsh7th/cmp-cmdline", -- cmdline completions
    "saadparwaiz1/cmp_luasnip", -- snippet completions
    "windwp/nvim-autopairs", -- closes parentesis, brackets, etc.
    "windwp/nvim-ts-autotag", -- closes html tags

    -- snippets
    "L3MON4D3/LuaSnip", --snippet engine
    "rafamadriz/friendly-snippets", -- a bunch of snippets to use

    -- LSP
    "neovim/nvim-lspconfig", -- enable LSP
    "williamboman/mason.nvim", -- simple to use language server installer
    "williamboman/mason-lspconfig.nvim", -- simple to use language server installer
    "jose-elias-alvarez/null-ls.nvim", -- enabling formatting for non-LSP plugins (like prettier, linters...)
    { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} }, -- shows partial updates from lsp

    "hrsh7th/cmp-nvim-lsp", -- LSP auto-completion support
    "hrsh7th/cmp-nvim-lua", -- lua syntax auto-complete

    { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }, -- treesitter a common parser to improve landguages
    "numToStr/Comment.nvim", -- easily comment stuff
    "JoosepAlviste/nvim-ts-context-commentstring", -- treesitter integration for better commenting

    -- hightlight
    "nvim-tree/nvim-web-devicons", -- trouble dependency
    "folke/trouble.nvim", -- hightlights issues inline
    -- 'lewis6991/gitsigns.nvim', -- git indicators

    -- navigation
    "nvim-telescope/telescope.nvim", -- fuzzy search
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }, -- using native program
    { "AckslD/nvim-neoclip.lua", requires = { 'kkharji/sqlite.lua', module = 'sqlite' } }, -- clipboard history
    'kyazdani42/nvim-tree.lua', -- file explorer
    {"akinsho/toggleterm.nvim", tag = '*'}, -- terminal

    -- appearance
    'xiyaowong/nvim-transparent', -- making sure we have a transparent bg regardless of the theme
    "akinsho/bufferline.nvim", -- buffer headers (like tabs)
    "moll/vim-bbye", -- closes windows without never exiting nvim
    'nvim-lualine/lualine.nvim', -- status line
    "norcalli/nvim-colorizer.lua", -- hex color detection

    'folke/tokyonight.nvim',
    'tanvirtin/monokai.nvim',
}

-- Install your plugins here
return packer.startup(function(use)
    for _, plugin in ipairs(plugins) do
        use(plugin)
    end

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
