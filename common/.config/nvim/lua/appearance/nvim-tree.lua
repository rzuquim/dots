
if IsDiff() then
  return
end

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    vim.notify("Could not load nvim tree. Falling back to Lex.")
    vim.api.nvim_set_keymap("n", "<leader>e", ":Lex 30<CR>", { noremap = true, silent = true })
    return
end

local api = require('nvim-tree.api')

nvim_tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    on_attach = function(bufnr)
        local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        local function map(key, section, label)
            vim.keymap.set('n', key, section, opts(label))
        end

        map('<CR>', api.node.open.edit, 'Open')
        map('o', api.node.open.edit, 'Open')
        map('h', api.node.navigate.parent_close, 'Close Directory')
        map('v', api.node.open.vertical, 'Open: Vertical Split')
        map('x', api.node.open.horizontal, 'Open: Horizontal Split')
        map('n', api.fs.create, 'Create')
        map('<DEL>', api.fs.remove, 'Delete')
        map('<F2>', api.fs.rename, 'Rename')
        map('d', api.fs.cut, 'Cut')
        map('y', api.fs.copy.node, 'Copy')
        map('p', api.fs.paste, 'Paste')
        map('Y', api.fs.copy.relative_path, 'Copy Relative Path')
        map('<C-y>', api.fs.copy.absolute_path, 'Copy Absolute Path')
        map('x', api.marks.toggle, 'Toggle Bookmark')
        map('P', api.marks.bulk.move, 'Move Bookmarked')
    end,
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    view = {
        side = "left",
    },
    actions = {
        open_file = {
            quit_on_open = true
        },
    },
    renderer = {
        highlight_git = true,
        root_folder_modifier = ":t",
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    deleted = "",
                    untracked = "U",
                    ignored = "◌",
                },
                folder = {
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                },
            }
        }
    }
}

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = api.tree.open })
