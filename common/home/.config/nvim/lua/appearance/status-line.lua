local status_ok, line = pcall(require, "lualine")

if not status_ok then
    vim.notify('Could not load status line!')
end

--TODO: git blame line
--[[ local git = require("git_helpers")

local right_line
if git.available() then
    right_line = { git.blame_line, 'encoding', 'filetype' }
else
    right_line = { 'encoding', 'filetype' }
end ]]

-- ########################
-- CURRENT PROJECT
-- ########################
local pwd = vim.fn.getcwd()
local last_dir = ''
for path in string.gmatch(pwd, "[^/]+") do -- iterate through dirs
    last_dir = path
end

local currentProject = function()
    return last_dir
end

line.setup {
    options = {
        disabled_filetypes = { 'NvimTree' },
    },
    sections = {
        lualine_a = { currentProject },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'mode', 'filename' },
        lualine_x = { 'encoding', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
}
