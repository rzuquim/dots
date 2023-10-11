local transparent_ok, transparent = pcall(require, "transparent")

if not transparent_ok then
    vim.notify("Could not require transparent! No wifu for you!")
    return
end

-- bg tranparency default config
transparent.setup {
    extra_groups = { -- table/string: additional groups that should be cleared
        "BufferLineTabClose",
        "BufferlineBufferSelected",
        "BufferLineFill",
        "BufferLineBackground",
        "BufferLineSeparator",
        "BufferLineIndicatorSelected",
    },
    exclude_groups = {
    },
}

