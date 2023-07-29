local status_ok, telescope = pcall(require, "telescope.builtin")
if not status_ok then
    vim.notify('Could not load telescope! No search for you today.')
    return
end

local M = {}
M.find_project_files = function()
    local git_find_ok, _ = pcall(telescope.git_files)
    if not git_find_ok then
        telescope.find_files()
    end
end
return M
