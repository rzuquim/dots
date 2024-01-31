local function keymap(mode, key_combination, cmd, custom_opts)
    custom_opts = custom_opts or {}
    local opts = vim.tbl_deep_extend(
        "force",
        custom_opts,
        {
            noremap = true, -- no recursive key bindings to avoid confusion
            silent = true, -- no output for each remap
        }
    )

    vim.api.nvim_set_keymap(mode, key_combination, cmd, opts) -- short keymap alias
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes reference (normal = "n", insert = "i", visual = "v", visual_block = "x", term = "t", command = "c")

-- List keybidings not working
-- <C-S-Enter>
-- <C-k> ???
-- <A-J> ???

-- Window management
keymap("n", "<C-Up>", "<C-w>k") -- focus up
keymap("n", "<C-Down>", "<C-w>j") -- focus down
keymap("n", "<C-Left>", "<C-w>h") -- focus left
keymap("n", "<C-Right>", "<C-w>l") -- focus right
keymap("n", "<A-->", ":vertical resize -2<CR>") -- resize left
keymap("n", "<A-+>", ":vertical resize +2<CR>") -- resize right

keymap("n", "<C-A-k>", "<C-w>K") -- move window up
keymap("n", "<C-A-j>", "<C-w>J") -- move window down
keymap("n", "<C-A-h>", "<C-w>H") -- move window left
keymap("n", "<C-A-l>", "<C-w>L") -- move window right

keymap("n", "<C-w>", ":Bdelete!<CR>") -- close buffer

-- Move lines
keymap("n", "<A-Up>", ":m .-2<CR>") -- move live up
keymap("n", "<A-Down>", ":m .+1<CR>") -- move live down
keymap("v", "<A-Up>", ":m '<-2<CR>gv=gv") -- move selection up
keymap("v", "<A-Down>", ":m '>+1<CR>gv=gv") -- move selection down
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv") -- move selection up
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv") -- move selection down

keymap("n", "<S-Tab>", "<<") -- untab with shift tab
keymap("i", "<S-Tab>", "<C-d>") -- untab with shift tab
keymap("v", "<Tab>", ">gv") -- tab in visual mode
keymap("v", "<S-Tab>", "<gv") -- untab in visual mode

keymap("v", "<leader>s", ":Sort<CR>") -- sort the selected text
keymap("v", "<leader>u", ":Sort u<CR>") -- eliminate duplicates and sort in the selected text

-- Files
keymap("n", "<leader>e", ":NvimTreeFindFileToggle<CR>") -- open file explorer

-- Quick Selection
keymap("n", "vv", "^v$") -- select line
keymap("n", "<C-a>", "GVgg") -- select all text

-- Navigation
keymap("n", "<S-l>", ":bnext<CR>")
keymap("n", "<S-h>", ":bprevious<CR>")

keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

keymap("n", "<A-Left>", "<C-O>")
keymap("n", "<A-Right>", "<C-I>")

-- Clipboard
keymap("v", "p", '"_dP') -- preventing clipboard overwrite behavior on replace
keymap("n", "<leader>y", ':Telescope neoclip theme=ivy<CR>') -- search in clipboard history

-- Search and replace
keymap("n", "<Esc>", ":noh<CR>") -- remove search highlight
keymap("v", "<C-f>", 'y<Esc>:/<C-R>"<CR>') -- search all occurences of selected text
keymap("v", "<C-h>", 'y<Esc>:%s/<C-R>"//g<Left><Left>') -- replace all occurences of selected text
keymap("n", "<C-f>", ":Telescope current_buffer_fuzzy_find theme=ivy<CR>") -- search in current file
keymap("n", "<C-P>", "<CMD>lua require'search.custom_find'.find_project_files()<CR>")
keymap("n", "<leader>/", ":Telescope live_grep theme=ivy<CR>") -- find in content of all files
keymap("n", "<leader>gb", ":Telescope git_branches theme=ivy<CR>") -- search and switch git branches
keymap("n", "<leader>gc", ":Telescope git_commits theme=ivy<CR>") -- search and switch git commits
keymap("n", "<F24>", ":Telescope lsp_references theme=ivy<CR>") -- search symbol usages
keymap("n", "<leader>?", ":Telescope help_tags<CR>") -- search symbol usages

-- Text transformation
keymap("v", "<leader>Cp", "gsp") -- PascalCase
keymap("v", "<leader>Cc", "gsc") -- camelCase
keymap("v", "<leader>C_", "gs_") -- snake_case
keymap("v", "<leader>CU", "gsu") -- UPPER_CASE
keymap("v", "<leader>Ct", "gst") -- Title Case
keymap("v", "<leader>Cs", "gss") -- Sentence case
keymap("v", "<leader>C-", "gs-") -- kebab-case
keymap("v", "<leader>C.", "gs.") -- dot.case

-- Quit everything writing all buffers to the disk
keymap("n", "<leader>ww", ":wqa!<CR>")

if vim.g.neovide then
    -- zoom on neovide
    keymap("n", "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>") -- bigger font
    keymap("n", "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>") -- smaller font
    keymap("n", "<C-=>", ":lua vim.g.neovide_scale_factor = 1.0<CR>") -- regular size
end
