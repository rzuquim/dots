local trouble_ok, trouble = pcall(require, "trouble")

if not trouble_ok then
    vim.notify("Could not require trouble! Inline issues won't show!")
    return
end

trouble.setup {
    action_keys = {
        open_vsplit = "<C-CR>",
    },
    auto_preview = false,
    use_diagnostic_signs = true,
}

