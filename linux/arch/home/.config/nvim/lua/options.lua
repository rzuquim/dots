-- :help options
local options = {
    backup = false, -- do not create a backup file (we are mostly using git and undodir)
    clipboard = "unnamedplus", -- allows neovim to access the system clipboard
    cmdheight = 2, -- more space in the neovim command line for displaying messages
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp (auto-complete plugin)
    conceallevel = 0, -- so that `` is visible in markdown files
    fileencoding = "utf-8", -- the encoding written to a file
    hlsearch = true, -- highlight all matches on previous search pattern
    incsearch = true, -- incremental search (show partial results while typing)
    ignorecase = true, -- ignore case in search patterns
    mouse = "a", -- allow the mouse to be used in neovim
    pumheight = 10, -- pop up menu height
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2, -- always show tabs
    smartcase = true, -- smart case (lowercase search is insensitive, other cases no)
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
    writebackup = false, -- blocks edition if a file is being edited by another program
    expandtab = true, -- convert tabs to spaces
    shiftwidth = 4, -- the number of spaces inserted for each indentation
    tabstop = 4, -- insert 2 spaces for a tab
    softtabstop = 4, -- insert 2 spaces for a tab
    cursorline = false, -- highlight the current line
    number = true, -- set numbered lines
    relativenumber = true, -- set relative numbered lines
    numberwidth = 3, -- set number column width to 2 {default 4}
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    wrap = false, -- display lines as one long line
    scrolloff = 8, -- always at least 8 lines when scrolling down
    sidescrolloff = 8, -- always at least 8 columns when scrolling left
    colorcolumn = "120", -- marker to set the desired max length

    undofile = true,

    termguicolors = true, -- i like good colors
    updatetime = 300, -- and fast update times
    list = true, -- show redundant spaces
}

if os then -- does not work in windows
    options.undodir = os.getenv("HOME") .. "/.vim/undodir" -- using persitent undos
end

-- reading every options prop and setting into the action vim.opt
for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.opt.shortmess:append "c" -- avoid prompts on auto-complete mistakes

-- this is section is here to remind us that we can set options using vimscript with vim.cmd

vim.cmd [[hi ColorColumn guibg=#2d2d2d ctermbg=246]]
vim.cmd [[set lcs+=space:·]]  -- show spaces as dots
-- vim.cmd [[set iskeyword+=-]]                 -- consider words with - as a single word
