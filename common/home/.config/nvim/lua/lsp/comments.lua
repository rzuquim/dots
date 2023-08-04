local status_ok, comments = pcall(require, "Comment")
if not status_ok then
    vim.notify("Coult not require comments generator.")
    return
end

comments.setup {
    toggler = {
        line = '<leader>cc',
        block = '<leader>cb',
    },
    opleader = {
        line = '<leader>cc',
        block = '<leader>cb',
    },
    extra = {
        above = '<leader>cO',
        below = '<leader>co',
        eol = '<leader>cA',
    },
    pre_hook = function(ctx)
        local U = require "Comment.utils"

        local location = nil
        if ctx.ctype == U.ctype.block then
            location = require("ts_context_commentstring.utils").get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require("ts_context_commentstring.utils").get_visual_start_location()
        end

        return require("ts_context_commentstring.internal").calculate_commentstring {
            key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
            location = location,
        }
    end,
}
