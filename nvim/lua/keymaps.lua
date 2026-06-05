local keymap = vim.keymap.set

-- General
keymap("n", "<leader>h", ":noh<CR>", { desc = "Clear search highlights" })
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Buffers
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })
keymap("n", "gn", ":bnext<CR>", { desc = "Next buffer" })
keymap("n", "gp", ":bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "gd", ":bdelete<CR>", { desc = "Delete buffer" })

keymap("n", "<leader>n", ":bnext<CR>")
keymap("n", "<leader>p", ":bprevious<CR>")
keymap("n", "<leader>d", ":bdelete<CR>")
keymap("n", "<leader>ba", "<cmd>%bd<CR>", { desc = "Close all buffers" })
keymap("n", "<leader>bo", "<cmd>%bd|e#|bd#<CR>", { desc = "Close all other buffers" })

-- Telescope (Mapped to the functions we will install)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find word under cursor" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "List open buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "List help tags" })
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits (Telescope)" })

-- Git
keymap("n", "<leader>gl", "<cmd>Git log --graph --oneline --decorate --all<cr>", { desc = "Git log graph (Fugitive)" })

-- Trouble
keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
keymap("n", "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
keymap("n", "gR", "<cmd>Trouble lsp_references toggle<cr>", { desc = "LSP References (Trouble)" })

-- Terminal
keymap("n", "<leader>t", ":botright 15split | term<CR>", { desc = "Open terminal in bottom split" })
keymap("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

