-- Options (from old vimrc/init.vim)
local opt = vim.opt

opt.termguicolors = true
vim.cmd("syntax enable")

opt.number = true
opt.relativenumber = false -- Set to true if you like relative numbers

-- Formatting
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true

-- Search
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Visual/UI
opt.showmatch = true
opt.list = true
opt.listchars = { tab = "  ", eol = "$", trail = "~", extends = ">", precedes = "<" }
opt.laststatus = 3 -- Global statusline
opt.showtabline = 2 -- Always show tabline
opt.cursorline = true
-- System
opt.clipboard = "unnamedplus"
opt.hidden = true
opt.history = 256
opt.timeoutlen = 500
opt.updatetime = 300
opt.undofile = true -- Maintain undo history between sessions

-- Filetype specific logic (Legacy port)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "xml" },
  callback = function()
    vim.keymap.set("n", "<leader>cf", ":silent 1,$!xmllint --format --recover - 2>/dev/null<CR>", { buffer = true })
  end,
})

-- spell/wrap/etc. are window-local, so they must be explicitly toggled off
-- on every buffer switch or they'd leak into non-markdown buffers sharing the window
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*",
  callback = function()
    local is_markdown = vim.bo.filetype == "markdown"
    opt.spell = is_markdown
    opt.wrap = is_markdown
    opt.linebreak = is_markdown
    opt.list = not is_markdown
    opt.conceallevel = is_markdown and 2 or 0
  end,
})
