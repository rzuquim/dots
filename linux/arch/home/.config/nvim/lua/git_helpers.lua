local M = {}

M.available_cache = nil
M.available = function()
    if not M.available_cache == nil then
        return M.available_cache
    end

    vim.fn.system('git rev-parse --is-inside-work-tree')
    M.available_cache = vim.v.shell_error == 0
    return M.available_cache
end

M.blame_line = function ()
    local current_file = vim.fn.expand('%:.') -- relative file name
    local lineNum = vim.api.nvim_win_get_cursor(0)[1]

    -- local a = vim.fn.system('git blame -L ' .. lineNum .. ' ' .. current_file)
    vim.notify("found " .. current_file .. " in line " .. lineNum)
    return "todo line blame"
end

return M
