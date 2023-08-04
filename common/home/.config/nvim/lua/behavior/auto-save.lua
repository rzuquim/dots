local status_ok, autosave = pcall(require, 'auto-save')
if not status_ok then
    vim.notify("Could not load auto-save! Don't forget to save your changes")
    return
end

local function ends_with(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end

autosave.setup {
    condition = function(buf)
        local file_name = vim.api.nvim_buf_get_name(buf)
        if ends_with(file_name, 'nvim/lua/plugins.lua') then
            vim.notify("PLUGINS FILE! WE WON'T AUTO-SAVE IT! SAVING WILL TRIGGER PLUGINS SYNC.")
            return false
        end

        local fn = vim.fn
        local utils = require("auto-save.utils.data")
        if (not fn.getbufvar(buf, "&modifiable")) == 1 or (not utils.not_in(fn.getbufvar(buf, "&filetype"), {})) then
            return false
        end
        return true -- can save
    end
}
