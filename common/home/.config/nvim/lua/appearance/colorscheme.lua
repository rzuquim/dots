local current_hour = os.date('%H')
local colorscheme

if tonumber(current_hour) > 17 then 
    colorscheme = "tokyonight" -- night time
else
    colorscheme = "monokai" -- day time
end

local status_ok, scheme = pcall(require, colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

scheme.setup {
    transparent = true,
    styles = {
        sidebars = "transparent",
        floats = "transparent",
    }
}

-- variant selector
if colorscheme == "monokai" then
    vim.cmd("colorscheme monokai_ristretto")
    return
end

if colorscheme == "tokyonight" then
    vim.cmd("colorscheme tokyonight-moon")
    return
end

vim.cmd("colorscheme " .. colorscheme)

