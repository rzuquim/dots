local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    vim.notify("Could not require cmp! Auto-complete is disabled!")
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    vim.notify("Could not require luasnip! Snippets are disabled!")
    return
end

require("luasnip/loaders/from_vscode").lazy_load()

-- utils for snippet "super-tab" behavior
local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--   פּ ﯟ   some other good icons
local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ["<Up>"] = cmp.mapping.select_prev_item(), -- select previous item
        ["<Down>"] = cmp.mapping.select_next_item(), -- select the next item

        ["<C-Up>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }), -- scroll up the help
        ["<C-Down>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }), -- scroll doown the help

        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- opens auto-complete without any input

        ["<Esc>"] = cmp.mapping { -- aborts the auto-complete without
            i = cmp.mapping.abort(), -- leaving curent mode
            c = cmp.mapping.close(),
        },

        ["<CR>"] = cmp.mapping.confirm { select = true }, -- accept selected or selects first item
        ["<Tab>"] = cmp.mapping(function(fallback) -- navigates through the snippet fields
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback) -- backwards fields navigation
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },
    -- <icon> <actual text> <source>
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            -- this concatonates the icons with the name of the item kind
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip  = "[Snippet]",
                buffer   = "[Buffer]",
                path     = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    },
    -- the order of the sources
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer", keyword_length = 5 },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
        documentation = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = false,
        native_menu = false,
    },
}
