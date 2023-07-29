local status_ok, which_key = pcall(require, 'which-key')
if not status_ok then
    vim.notify("Could not load which-key! Hope your memory is ok.")
    return
end

which_key.setup {
    icons = {
        separator = "",
        group = "",
    },
    window = {
        border = "single",
        position = "bottom",
        margin = { 0, 0, 0, 0 },
        padding = { 0, 0, 0, 0 },
        winblend = 0,
    },
}

which_key.register(
    {
        e = {
            name = " tree",
        },
        ['/'] = {
            name = " grep",
        },
        g = {
            name = " git",
            c = { " commits" },
            b = { " branches" }
        },
        f = { " format" },
        y = { " clipboard" },
        w = { " quit" },
        t = { " trouble" },
        ['?'] = { " help" },
        c = {
            name = " comment",
            c = { " line" },
            b = { " block" },
            O = { " line above" },
            o = { " line below" },
            A = { " end of the line" },
        }
    },
    {
        prefix = "<leader>",
    })

which_key.register(
    {
        s = { " sort" },
        u = { " unique" },
        c = {
            name = " comment",
            c = { " line" },
            b = { " block" },
        },
        C = {
            name = " case",
            p = "PascalCase",
            c = "camelCase",
            _ = "snake_case",
            u = "UPPER_CASE",
            t = "Title Case",
            s = "Sentence case",
            ['.'] = "dot.case",
            ['-'] = "kebab-case",
        }
    },
    {
        mode = "v",
        prefix = "<leader>",
    }
)
