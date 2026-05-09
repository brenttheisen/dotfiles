local keymap = vim.keymap.set

-- General
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Buffers
keymap("n", "gn", ":bnext<CR>", { desc = "Next buffer" })
keymap("n", "gp", ":bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "gd", ":bdelete<CR>", { desc = "Delete buffer" })

keymap("n", "<leader>n", ":bnext<CR>")
keymap("n", "<leader>p", ":bprevious<CR>")
keymap("n", "<leader>d", ":bdelete<CR>")

-- Telescope (Mapped to the functions we will install)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "List open buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "List help tags" })

-- Trouble
keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
keymap("n", "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
keymap("n", "gR", "<cmd>Trouble lsp_references toggle<cr>", { desc = "LSP References (Trouble)" })
