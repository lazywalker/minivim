-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { silent = true, desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { silent = true, desc = "Move to below window" })
keymap("n", "<C-k>", "<C-w>k", { silent = true, desc = "Move to above window" })
keymap("n", "<C-l>", "<C-w>l", { silent = true, desc = "Move to right window" })

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", { silent = true, desc = "Resize window taller" })
keymap("n", "<C-Down>", ":resize +2<CR>", { silent = true, desc = "Resize window shorter" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true, desc = "Resize window narrower" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true, desc = "Resize window wider" })

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", { silent = true, desc = "Next buffer" })
keymap("n", "<S-h>", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", { silent = true, desc = "Close buffer" })
keymap("n", "<leader>q", "<cmd>Bdelete!<CR>", { silent = true, desc = "Close buffer" })

-- Better paste
keymap("v", "p", '"_dP', { silent = true, desc = "Paste without yanking replaced text" })

-- Insert --
-- Press jj fast to enter
keymap("i", "jj", "<ESC>", { desc = "Exit insert mode" })

-- Move with control key
keymap("i", "<C-h>", "<Left>", { desc = "Move cursor left (insert)" })
keymap("i", "<C-j>", "<Down>", { desc = "Move cursor down (insert)" })
keymap("i", "<C-k>", "<Up>", { desc = "Move cursor up (insert)" })
keymap("i", "<C-l>", "<Right>", { desc = "Move cursor right (insert)" })

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", { silent = true, desc = "Indent left (visual)" })
keymap("v", ">", ">gv", { silent = true, desc = "Indent right (visual)" })

-- Better delete a word backwards with Ctrl-Backspace.
keymap("i", "<C-BS>", "<C-W>", { desc = "Delete word backwards (insert)" })

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, desc = "Toggle file explorer" })

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true, desc = "Find files" })
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", { silent = true, desc = "Live grep" })
keymap("n", "<leader>fp", ":Telescope projects<CR>", { silent = true, desc = "Find projects" })
keymap("n", "<leader>fb", ":Telescope buffers<CR>", { silent = true, desc = "Find buffers" })
keymap("n", "<leader>ls", ":Telescope lsp_document_symbols<CR>", { silent = true, desc = "LSP: document symbols" })
keymap("n", "<leader>lS", ":Telescope lsp_workspace_symbols<CR>", { silent = true, desc = "LSP: workspace symbols" })

-- Git (gitsigns.nvim)
-- https://neovim.io/doc/user/diagnostic.html
keymap("n", "<leader>gdp", ":Gitsigns diffthis<CR>", { silent = true, desc = "Git: diff buffer" })
keymap("n", "<leader>ghu", ":Gitsigns prev_hunk<CR>", { silent = true, desc = "Git: previous hunk" })
keymap("n", "<leader>ghd", ":Gitsigns next_hunk<CR>", { silent = true, desc = "Git: next hunk" })
keymap("n", "<leader>ghp", ":Gitsigns preview_hunk<CR>", { silent = true, desc = "Git: preview hunk" })
keymap("n", "<leader>ghl", ":Gitsigns blame_line<CR>", { silent = true, desc = "Git: blame line" })
keymap("n", "<leader>gbp", ":Gitsigns blame_line<CR>", { silent = true, desc = "Git: blame line" })

-- Lsp
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", { silent = true, desc = "LSP: format buffer" })
