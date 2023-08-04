local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    vim.notify('Could not load telescope! No search for you today.')
    return
end

local actions = require "telescope.actions"

telescope.setup {
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },

        mappings = {
            i = {
            },

            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["x"] = actions.select_horizontal,
                ["v"] = actions.select_vertical,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["?"] = actions.which_key,
            },
        },
    },
    pickers = {
        find_files = { theme = "ivy" },
        git_files = { theme = "ivy" },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        }
    },

}

telescope.load_extension('fzf')

-- neoclip stores the clipboard history
local neoclip_status_ok, neoclip = pcall(require, "neoclip")
if not neoclip_status_ok then
    vim.notify('Could not load neoclip! No clipboard history for you.')
    return
end

neoclip.setup {
    default_register = '+',
    -- enable_persistent_history = true,
    enable_macro_history = false,
    on_select = {
        move_to_front = true,
        close_telescope = true,
    },
}

telescope.load_extension('neoclip')




