vim.g.mapleader = " "

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true  -- case insensitive search
vim.opt.smartcase = true   -- unless the pattern contains uppercase

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- built-in autocompletion, replaces nvim-cmp
vim.opt.autocomplete = true
-- "." current buffer, "w" other windows, "b" other loaded buffers, capped at 5
-- matches each; "o" is 'omnifunc', which LSP points at vim.lsp.omnifunc().
vim.opt.complete = { ".^5", "w^5", "b^5", "o" }
-- noselect: nothing is inserted until <C-y> picks an item.
-- popup: show the item's documentation next to the menu.
vim.opt.completeopt = { "menuone", "noselect", "popup", "fuzzy" }
vim.opt.pumheight = 10

vim.opt.laststatus = 2
vim.opt.statusline = " %f %m%=%l:%c  %p%% "

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '·', space = '·' }

vim.opt.wrap = true        -- enable line wrapping
vim.opt.linebreak = true   -- break at word boundaries, not mid-word

-- mappings to switch away from terminal windows running terminal mode
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]])
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]])
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]])
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]])

-- mapping that toggles the diagnostic window for problems in the code.
vim.keymap.set("n", "<leader>er", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)

    if config.relative ~= "" and config.focusable then
        vim.api.nvim_win_close(win, false)
        return
    end
  end

  vim.diagnostic.open_float(nil, {
    focus = false,
    border = "rounded",
    source = true,
  })
end, { desc = "Toggle diagnostic float" })

